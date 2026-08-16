#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""RiddleQuiz — answer riddles for points."""
import random

RIDDLES = [
    ('What has keys but no locks, space but no room?', 'keyboard'),
    ('What gets wetter the more it dries?', 'towel'),
    ('What has a face and hands but no body?', 'clock'),
    ('What can travel the world while staying in a corner?', 'stamp'),
]

def check(answer, expected):
    return answer.strip().lower() == expected

def play():
    score = 0
    for question, expected in RIDDLES:
        print(question)
        if check(input('Answer: '), expected):
            score += 10
            print('Correct! Score:', score)
        else:
            print('No - the answer was %s.' % expected)
    print('Final score: %d/%d' % (score, len(RIDDLES) * 10))

if __name__ == "__main__":
    play()
