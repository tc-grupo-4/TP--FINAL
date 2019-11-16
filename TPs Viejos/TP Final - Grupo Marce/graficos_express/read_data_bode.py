import read_xls
import read_csv
import pathlib


def read_data_bode(filename):
    if pathlib.Path(filename).suffix == ".xlsx":
        return read_xls.read_excel_data(filename)
    elif pathlib.Path(filename).suffix == ".csv":
        return read_csv.read_csv_bode(filename)
