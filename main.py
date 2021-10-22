from process_data import process_data
from time_range import determine_time_range

if __name__ == "__main__":
    # Process the raw data.
    process_data()

    # Determine the probability of the different time ranges.
    determine_time_range()
