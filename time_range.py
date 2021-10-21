from pathlib import Path
from statistics import stdev

import pandas as pd

from process_data import get_time_taken

BASE_PATH = "data"
AVERAGES = BASE_PATH + "/output/averages.csv"
EASY_PATH = BASE_PATH + "/all-easy.txt"
HARD_PATH = BASE_PATH + "/all-hard.txt"
OUTPUT = BASE_PATH + "/output/"


def determine_time_range():
    df = pd.read_csv(AVERAGES)
    easy_range = determine_percentages(df.iloc[0]['easy_time'], EASY_PATH)
    hard_range = determine_percentages(df.iloc[0]['hard_time'], HARD_PATH)
    data = {
        'easy_slow': [easy_range.get('slow')],
        'easy_avg': [easy_range.get('avg')],
        'easy_fast': [easy_range.get('fast')],
        'hard_slow': [hard_range.get('slow')],
        'hard_avg': [hard_range.get('avg')],
        'hard_fast': [hard_range.get('fast')]
    }
    df = pd.DataFrame(data=data, columns=['easy_slow', 'easy_avg', 'easy_fast', 'hard_slow', 'hard_avg', 'hard_fast'])
    df.to_csv(Path(OUTPUT + 'time_ranges.csv'), index=False, header=True)


def determine_percentages(avg_time, file_path):
    with open(file_path) as f:
        lines = f.readlines()
        time_taken = get_time_taken(lines)
        std = round(stdev(time_taken), 4)

    slow, avg, fast = 0, 0, 0
    for time in time_taken:
        if time > (avg_time + std):
            slow += 1
        elif time < (avg_time - std):
            fast += 1
        else:
            avg += 1

    return {
        'slow': round(slow / len(time_taken), 2),
        'avg': round(avg / len(time_taken), 2),
        'fast': round(fast / len(time_taken), 2)
    }
