import shutil
from pathlib import Path
from statistics import mean
import pandas as pd

BASE_PATH = "data"
EASY_PATH = BASE_PATH + "/all-easy.txt"
HARD_PATH = BASE_PATH + "/all-hard.txt"
OUTPUT = BASE_PATH + "/output/"


def process_file(file_path):
    """
    Process the file and returns the average accuracy and time taken for the specific difficulty.
    :param file_path: the path to the file.
    :return: a dictionary.
    """
    with open(file_path) as f:
        lines = f.readlines()
        time_taken = get_time_taken(lines)
        accuracy = get_average_accuracy(lines)
        avg_time_taken = round(mean(time_taken), 4)
        avg_accuracy = round(mean(accuracy), 2)
        return {'accuracy': avg_accuracy, 'time': avg_time_taken}


def get_time_taken(contents):
    """
    Creates a list of the time taken to complete the task where the time is converted from ns to s.
    :param contents: the lines in the file.
    :return: a list of times in seconds.
    """
    time_taken = []
    for line in contents:
        time = line.partition('Question (ns): ')[2]
        if time:
            time = float(time)
            time_seconds = time / 1000000000
            time_taken.append(time_seconds)
    return time_taken


def get_average_accuracy(contents):
    """
    Gets the average accuracy from the file.
    :param contents: the lines in the file.
    :return: a list with the average accuracies.
    """
    accuracy = []
    for line in contents:
        correct = line.partition('Number Questions Correctly Answered: ')[2]
        if correct:
            accuracy.append(int(correct) / 50)
    return accuracy


def process_data():
    """
    Makes an output directory if it doesn't already exist, overwrites existing directory if it does exist. Gets the
    average time and accuracy for each difficulty and exports all these values to a csv in the output directory.
    :return:
    """
    if Path(OUTPUT).exists() and Path(OUTPUT).is_dir():
        shutil.rmtree(Path(OUTPUT))
    Path(OUTPUT).mkdir(parents=True, exist_ok=True)

    easy_stats = process_file(EASY_PATH)
    hard_stats = process_file(HARD_PATH)

    data = {
        'easy_time': [easy_stats.get('time')],
        'easy_accuracy': [easy_stats.get('accuracy')],
        'hard_time': [hard_stats.get('time')],
        'hard_accuracy': [hard_stats.get('accuracy')]
    }
    df = pd.DataFrame(data, columns=['easy_time', 'easy_accuracy', 'hard_time', 'hard_accuracy'])
    df.to_csv(Path(OUTPUT + 'averages.csv'), index=False, header=True)
