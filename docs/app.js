const STORAGE_KEYS = {
  users: 'sb_users_v1',
  currentUser: 'sb_current_user_v1',
  reports: 'sb_reports_v1',
  profiles: 'sb_profiles_v1',
};

const cfg = window.SB_CONFIG || {};
const hasBackend = Boolean(cfg.url && cfg.anonKey && window.supabase);
const sb = hasBackend ? window.supabase.createClient(cfg.url, cfg.anonKey) : null;

let mediaRecorder;
let recordedChunks = [];
let timerInterval;
let seconds = 0;
let currentUserEmail = localStorage.getItem(STORAGE_KEYS.currentUser) || '';
let currentUserId = '';

function readStore(key, fallback) {
  try {
    const raw = localStorage.getItem(key);
    return raw ? JSON.parse(raw) : fallback;
  } catch {
    return fallback;
  }
}

function writeStore(key, value) {
  localStorage.setItem(key, JSON.stringify(value));
}

function slugName(name) {
  return String(name || 'file')
    .toLowerCase()
    .replace(/[^a-z0-9.-]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

async function uploadToBucket(bucket, file, folder = 'misc') {
  if (!sb || !file || !(file instanceof File) || !file.name) {
    return '';
  }

  const filePath = `${folder}/${Date.now()}-${slugName(file.name)}`;
  const { error } = await sb.storage.from(bucket).upload(filePath, file, {
    upsert: true,
  });

  if (error) {
    throw error;
  }

  const { data } = sb.storage.from(bucket).getPublicUrl(filePath);
  return data?.publicUrl || '';
}

function setupTabs() {
  const buttons = document.querySelectorAll('.tab-btn');
  const panels = document.querySelectorAll('.tab-panel');

  buttons.forEach((btn) => {
    btn.addEventListener('click', () => {
      buttons.forEach((b) => b.classList.remove('active'));
      panels.forEach((p) => p.classList.remove('active'));
      btn.classList.add('active');
      document.getElementById(`tab-${btn.dataset.tab}`).classList.add('active');
    });
  });
}

async function loadApps() {
  const response = await fetch('apps.json');
  const apps = await response.json();
  const root = document.getElementById('apps');

  root.innerHTML = apps
    .map(
      (app) => `
      <article class="card">
        <span class="badge">${app.channel}</span>
        <h3>${app.name}</h3>
        <p>${app.notes}</p>
        <p><strong>Version:</strong> ${app.version}</p>
        <p><strong>Platform:</strong> ${app.platform}</p>
        <a class="button" href="${app.downloadUrl}">Download</a>
      </article>
    `,
    )
    .join('');
}

function setupAuth() {
  const signupForm = document.getElementById('signupForm');
  const loginForm = document.getElementById('loginForm');
  const logoutBtn = document.getElementById('logoutBtn');

  signupForm.addEventListener('submit', async (event) => {
    event.preventDefault();
    const formData = new FormData(signupForm);
    const user = {
      name: String(formData.get('name')),
      phone: String(formData.get('phone')),
      email: String(formData.get('email')).toLowerCase(),
      password: String(formData.get('password')),
      createdAt: new Date().toISOString(),
    };

    if (hasBackend) {
      const { data, error } = await sb.auth.signUp({
        email: user.email,
        password: user.password,
        options: {
          data: {
            full_name: user.name,
            phone: user.phone,
          },
        },
      });

      if (error) {
        alert(error.message);
        return;
      }

      currentUserEmail = user.email;
      currentUserId = data.user?.id || '';
      localStorage.setItem(STORAGE_KEYS.currentUser, user.email);
      updatePortalVisibility();
      signupForm.reset();
      return;
    }

    const users = readStore(STORAGE_KEYS.users, []);
    if (users.some((u) => u.email === user.email)) {
      alert('Account already exists for this email.');
      return;
    }

    users.push(user);
    writeStore(STORAGE_KEYS.users, users);
    currentUserEmail = user.email;
    localStorage.setItem(STORAGE_KEYS.currentUser, user.email);
    updatePortalVisibility();
    signupForm.reset();
  });

  loginForm.addEventListener('submit', async (event) => {
    event.preventDefault();
    const formData = new FormData(loginForm);
    const email = String(formData.get('email')).toLowerCase();
    const password = String(formData.get('password'));

    if (hasBackend) {
      const { data, error } = await sb.auth.signInWithPassword({ email, password });
      if (error) {
        alert(error.message);
        return;
      }

      currentUserEmail = email;
      currentUserId = data.user?.id || '';
      localStorage.setItem(STORAGE_KEYS.currentUser, email);
      updatePortalVisibility();
      await renderReports();
      await renderLeaderboard();
      loginForm.reset();
      return;
    }

    const users = readStore(STORAGE_KEYS.users, []);
    const found = users.find((u) => u.email === email && u.password === password);
    if (!found) {
      alert('Invalid credentials.');
      return;
    }

    currentUserEmail = email;
    localStorage.setItem(STORAGE_KEYS.currentUser, email);
    updatePortalVisibility();
    loginForm.reset();
  });

  logoutBtn.addEventListener('click', () => {
    if (hasBackend) {
      sb.auth.signOut();
    }
    currentUserEmail = '';
    currentUserId = '';
    localStorage.removeItem(STORAGE_KEYS.currentUser);
    updatePortalVisibility();
  });
}

function updatePortalVisibility() {
  const authGate = document.getElementById('authGate');
  const portal = document.getElementById('profilePortal');
  const logoutBtn = document.getElementById('logoutBtn');

  if (currentUserEmail) {
    authGate.classList.add('hidden');
    portal.classList.remove('hidden');
    logoutBtn.classList.remove('hidden');
  } else {
    authGate.classList.remove('hidden');
    portal.classList.add('hidden');
    logoutBtn.classList.add('hidden');
  }
}

function setupAddressAutocomplete() {
  const input = document.getElementById('addressInput');
  const suggestionRoot = document.getElementById('addressSuggestions');
  let debounce;

  input.addEventListener('input', () => {
    clearTimeout(debounce);
    const query = input.value.trim();
    if (query.length < 4) {
      suggestionRoot.innerHTML = '';
      return;
    }

    debounce = setTimeout(async () => {
      try {
        const url = `https://nominatim.openstreetmap.org/search?format=jsonv2&q=${encodeURIComponent(query)}&limit=5`;
        const response = await fetch(url, {
          headers: {
            Accept: 'application/json',
          },
        });
        const results = await response.json();

        suggestionRoot.innerHTML = '';
        results.forEach((item) => {
          const btn = document.createElement('button');
          btn.type = 'button';
          btn.textContent = item.display_name;
          btn.addEventListener('click', () => {
            input.value = item.display_name;
            suggestionRoot.innerHTML = '';
          });
          suggestionRoot.appendChild(btn);
        });
      } catch {
        suggestionRoot.innerHTML = '';
      }
    }, 300);
  });
}

function setupProfileForm() {
  const profileForm = document.getElementById('profileForm');

  profileForm.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!currentUserEmail) {
      alert('Please log in first.');
      return;
    }

    const data = new FormData(profileForm);

    if (hasBackend && currentUserId) {
      try {
        const frontFile = data.get('idFront');
        const backFile = data.get('idBack');
        const introFile = data.get('introVideo');

        const frontUrl = await uploadToBucket('verification-docs', frontFile, `${currentUserId}/id`);
        const backUrl = await uploadToBucket('verification-docs', backFile, `${currentUserId}/id`);
        const introUrl = await uploadToBucket('intro-videos', introFile, `${currentUserId}/intro`);

        const payload = {
          user_id: currentUserId,
          user_email: currentUserEmail,
          role: String(data.get('role')),
          alias: String(data.get('alias')),
          address: String(data.get('address')),
          id_front_url: frontUrl,
          id_back_url: backUrl,
          intro_video_url: introUrl,
          recorded_video_captured: recordedChunks.length > 0,
        };

        const { error } = await sb.from('tester_profiles').upsert(payload, {
          onConflict: 'user_id',
        });

        if (error) {
          alert(error.message);
          return;
        }

        alert('Profile saved to backend.');
        await renderLeaderboard();
        return;
      } catch (err) {
        alert(`Profile save failed: ${err.message}`);
        return;
      }
    }

    const profiles = readStore(STORAGE_KEYS.profiles, {});

    profiles[currentUserEmail] = {
      role: String(data.get('role')),
      alias: String(data.get('alias')),
      address: String(data.get('address')),
      idFrontName: data.get('idFront')?.name || '',
      idBackName: data.get('idBack')?.name || '',
      introVideoName: data.get('introVideo')?.name || '',
      recordedVideoCaptured: recordedChunks.length > 0,
      updatedAt: new Date().toISOString(),
    };

    writeStore(STORAGE_KEYS.profiles, profiles);
    alert('Profile saved locally. Connect secure backend before production use.');
  });
}

function setupRecording() {
  const recordBtn = document.getElementById('recordBtn');
  const stopBtn = document.getElementById('stopBtn');
  const timerLabel = document.getElementById('recordTimer');
  const preview = document.getElementById('introPreview');

  recordBtn.addEventListener('click', async () => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
      recordedChunks = [];
      mediaRecorder = new MediaRecorder(stream);
      preview.srcObject = stream;
      preview.play();

      mediaRecorder.ondataavailable = (event) => {
        if (event.data.size > 0) {
          recordedChunks.push(event.data);
        }
      };

      mediaRecorder.onstop = () => {
        clearInterval(timerInterval);
        const blob = new Blob(recordedChunks, { type: 'video/webm' });
        preview.srcObject = null;
        preview.src = URL.createObjectURL(blob);
        preview.controls = true;
      };

      mediaRecorder.start();
      seconds = 0;
      timerLabel.textContent = '00:00';
      recordBtn.disabled = true;
      stopBtn.disabled = false;

      timerInterval = setInterval(() => {
        seconds += 1;
        const mm = String(Math.floor(seconds / 60)).padStart(2, '0');
        const ss = String(seconds % 60).padStart(2, '0');
        timerLabel.textContent = `${mm}:${ss}`;
        if (seconds >= 300) {
          stopBtn.click();
        }
      }, 1000);
    } catch {
      alert('Unable to access camera/mic for recording.');
    }
  });

  stopBtn.addEventListener('click', () => {
    if (!mediaRecorder) {
      return;
    }

    mediaRecorder.stop();
    mediaRecorder.stream.getTracks().forEach((track) => track.stop());
    recordBtn.disabled = false;
    stopBtn.disabled = true;
  });
}

function setupReportForm() {
  const form = document.getElementById('reportForm');
  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!currentUserEmail) {
      alert('Log in before submitting reports.');
      return;
    }

    const data = new FormData(form);
    const report = {
      id: crypto.randomUUID(),
      user: currentUserEmail,
      type: String(data.get('type')),
      severity: String(data.get('severity')),
      platform: String(data.get('platform')),
      build: String(data.get('build')),
      title: String(data.get('title')),
      description: String(data.get('description')),
      steps: String(data.get('steps')),
      attachment: data.get('attachment')?.name || '',
      createdAt: new Date().toISOString(),
    };

    if (hasBackend && currentUserId) {
      try {
        const attachmentUrl = await uploadToBucket('report-attachments', data.get('attachment'), `${currentUserId}/reports`);
        const payload = {
          user_id: currentUserId,
          reporter_email: currentUserEmail,
          type: report.type,
          severity: report.severity,
          platform: report.platform,
          build: report.build,
          title: report.title,
          description: report.description,
          steps: report.steps,
          attachment_url: attachmentUrl,
        };

        const { error } = await sb.from('qa_reports').insert(payload);
        if (error) {
          alert(error.message);
          return;
        }
      } catch (err) {
        alert(`Backend submit failed: ${err.message}`);
        return;
      }
    } else {
      const reports = readStore(STORAGE_KEYS.reports, []);
      reports.unshift(report);
      writeStore(STORAGE_KEYS.reports, reports);
    }

    const destination = String(data.get('destination'));
    if (destination === 'github') {
      const issueTitle = `[${report.platform}] ${report.type.toUpperCase()} - ${report.title}`;
      const issueBody = `Severity: ${report.severity}\nBuild: ${report.build}\nReporter: ${report.user}\n\nDescription:\n${report.description}\n\nRepro:\n${report.steps}`;
      const repo = cfg.githubRepo || 'REPLACE_WITH_YOUR_USERNAME/REPLACE_WITH_YOUR_REPO';
      window.open(
        `https://github.com/${repo}/issues/new?title=${encodeURIComponent(issueTitle)}&body=${encodeURIComponent(issueBody)}`,
        '_blank',
      );
    }

    if (destination === 'email') {
      const subject = `[QA] ${report.type.toUpperCase()} ${report.title}`;
      const body = `Severity: ${report.severity}\nPlatform: ${report.platform}\nBuild: ${report.build}\nReporter: ${report.user}\n\n${report.description}\n\nSteps:\n${report.steps}`;
      const reportEmail = cfg.reportEmail || 'you@superbytebrillence.com';
      window.location.href = `mailto:${reportEmail}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    }

    form.reset();
    await renderReports();
    await renderLeaderboard();
  });
}

async function renderReports() {
  const list = document.getElementById('reportList');
  const tpl = document.getElementById('reportItemTemplate');
  let reports = [];

  if (hasBackend && currentUserId) {
    const { data, error } = await sb
      .from('qa_reports')
      .select('type,severity,platform,build,title,description,reporter_email,created_at')
      .order('created_at', { ascending: false })
      .limit(30);

    if (!error) {
      reports = (data || []).map((item) => ({
        type: item.type,
        severity: item.severity,
        platform: item.platform,
        build: item.build,
        title: item.title,
        description: item.description,
        user: item.reporter_email,
        createdAt: item.created_at,
      }));
    }
  } else {
    reports = readStore(STORAGE_KEYS.reports, []);
  }

  if (!reports.length) {
    list.innerHTML = '<p>No reports yet.</p>';
    return;
  }

  list.innerHTML = '';
  reports.slice(0, 20).forEach((report) => {
    const node = tpl.content.cloneNode(true);
    node.querySelector('.pill').textContent = `${report.type} • ${report.severity}`;
    node.querySelector('.report-title').textContent = report.title;
    node.querySelector('.report-meta').textContent = `${report.platform} • ${report.build} • ${new Date(report.createdAt).toLocaleString()} • ${report.user}`;
    node.querySelector('.report-body').textContent = report.description;
    list.appendChild(node);
  });
}

function badgeForCount(count) {
  if (count >= 30) {
    return 'Legend QA';
  }
  if (count >= 15) {
    return 'Elite Hunter';
  }
  if (count >= 7) {
    return 'Core Tester';
  }
  if (count >= 3) {
    return 'Rising Tester';
  }
  return 'Starter';
}

async function renderLeaderboard() {
  const root = document.getElementById('leaderboard');
  let reports = [];
  let profileMap = {};

  if (hasBackend && currentUserId) {
    const reportsRes = await sb.from('qa_reports').select('reporter_email');
    const profilesRes = await sb.from('tester_profiles').select('user_email,alias,role');

    if (!reportsRes.error) {
      reports = (reportsRes.data || []).map((x) => ({ user: x.reporter_email }));
    }

    if (!profilesRes.error) {
      profileMap = (profilesRes.data || []).reduce((acc, item) => {
        acc[item.user_email] = { alias: item.alias, role: item.role };
        return acc;
      }, {});
    }
  } else {
    reports = readStore(STORAGE_KEYS.reports, []);
    const profiles = readStore(STORAGE_KEYS.profiles, {});
    profileMap = Object.keys(profiles).reduce((acc, email) => {
      acc[email] = { alias: profiles[email].alias, role: profiles[email].role };
      return acc;
    }, {});
  }

  const scoreboard = reports.reduce((acc, report) => {
    acc[report.user] = (acc[report.user] || 0) + 1;
    return acc;
  }, {});

  const rows = Object.entries(scoreboard)
    .map(([email, count]) => ({
      email,
      count,
      alias: profileMap[email]?.alias || email,
      role: profileMap[email]?.role || 'tester',
      badge: badgeForCount(count),
    }))
    .sort((a, b) => b.count - a.count);

  if (!rows.length) {
    root.innerHTML = '<p>No tester activity yet.</p>';
    return;
  }

  root.innerHTML = rows
    .map((row, idx) => {
      const spotlight = idx < 3 ? '<span class="spotlight">Spotlight</span>' : '';
      return `
        <div class="leader-row">
          <div>
            <strong>${row.alias}</strong>
            <p class="tiny-note">${row.role}</p>
          </div>
          <div>
            <span class="badge">${row.badge}</span>
            <p class="tiny-note">${row.count} submissions ${spotlight}</p>
          </div>
        </div>
      `;
    })
    .join('');
}

function setupAmbient() {
  const musicBtn = document.getElementById('musicToggle');
  const audio = new Audio();
  const sources = [
    'assets/audio/ambient.mp3',
    'https://raw.githubusercontent.com/Mejustmeb/superbyte-knowledgebase/main/assets/audio/ambient.mp3',
    'https://raw.githubusercontent.com/Mejustmeb/Mejustmeb.github.io/main/assets/audio/ambient.mp3',
  ];
  audio.loop = true;
  audio.preload = 'auto';
  audio.volume = 0.35;
  let on = false;

  musicBtn.addEventListener('click', async () => {
    if (!on) {
      let started = false;
      for (const src of sources) {
        try {
          audio.src = src;
          await audio.play();
          started = true;
          break;
        } catch {
          audio.pause();
          audio.currentTime = 0;
        }
      }

      if (!started) {
        alert('Unable to play ambient track. Check file path or browser autoplay settings.');
        return;
      }

      musicBtn.textContent = 'Stop Ambient';
      on = true;
    } else {
      audio.pause();
      audio.currentTime = 0;
      musicBtn.textContent = 'Play Ambient';
      on = false;
    }
  });
}

function bootstrap() {
  setupTabs();
  setupAuth();
  setupAddressAutocomplete();
  setupProfileForm();
  setupRecording();
  setupReportForm();
  setupAmbient();
  updatePortalVisibility();
  renderReports();
  renderLeaderboard();

  if (hasBackend) {
    sb.auth.getUser().then(({ data }) => {
      if (data?.user) {
        currentUserEmail = data.user.email || currentUserEmail;
        currentUserId = data.user.id || '';
        localStorage.setItem(STORAGE_KEYS.currentUser, currentUserEmail || '');
        updatePortalVisibility();
        renderReports();
        renderLeaderboard();
      }
    });

    sb.auth.onAuthStateChange((_event, session) => {
      if (session?.user) {
        currentUserEmail = session.user.email || '';
        currentUserId = session.user.id || '';
        localStorage.setItem(STORAGE_KEYS.currentUser, currentUserEmail);
      } else {
        currentUserEmail = '';
        currentUserId = '';
        localStorage.removeItem(STORAGE_KEYS.currentUser);
      }
      updatePortalVisibility();
      renderReports();
      renderLeaderboard();
    });
  }

  loadApps().catch((err) => {
    const root = document.getElementById('apps');
    root.innerHTML = `<p>Failed to load app list: ${err.message}</p>`;
  });
}

bootstrap();
