# coding=utf-8
import sys
import os
import codecs
import random


def read_questions_set(questions_file_name):
    global questions_set, questions, in_question, questions_file, line, new_question, empty_line, question
    questions_set = []
    questions = []  # empty questions list
    in_question = False
    with codecs.open(questions_file_name, "r", "utf-8") as questions_file:
        for line in questions_file:  # read file line by line
            line = line.strip()  # perform striptease

            new_question = line.startswith(u'\z')
            empty_line = line == ''

            if in_question and (new_question or empty_line):
                questions.append(question)
                in_question = False

            if new_question:
                in_question = True
                question = line[len(u'\z '):].strip()  # remove line start
            elif in_question:
                question += os.linesep + line

            if line.startswith(u'\hrule'):
                questions_set.append(questions)
                questions = []

    if in_question:
        questions.append(question)
    questions_set.append(questions)

    return questions_set


def select_questions(questions_set, parts):
    selected_questions = []

    i = 0
    for q_set in questions_set:
        k = parts[i]
        i += 1
        selected_questions += random.sample(q_set, k)  # select k random questions

    return selected_questions


def main():

    questions_file_name = sys.argv[1] if len(sys.argv) > 1 else "prost.tex"  # default file if nothing is specified
    exam_file_name = sys.argv[2] if len(sys.argv) > 2 else "exam.tex"  # default file if nothing is specified
    tickets_count = int(sys.argv[3]) if len(sys.argv) > 3 else 20  # 20 tickets by default
    parts = [int(s) for s in (sys.argv[4:] if len(sys.argv) > 3 else [1])]

    questions_set = read_questions_set(questions_file_name)

    while len(parts) < len(questions_set):
        parts += parts

    with codecs.open(exam_file_name, "w", "utf-8") as exam_file:
        exam_file.write(u'' + os.linesep * 2)  # write in the very beginning of the file

        for i in range(tickets_count):
            selected_questions = select_questions(questions_set, parts)

            exam_file.write(u'\section*{Задание %d}' % (i + 1) + os.linesep)
            exam_file.write(u'\setcounter{curtask}{1}' + os.linesep * 2)

            for q in selected_questions:
                exam_file.write(u'\\begin{task}' + os.linesep + q + os.linesep + '\end{task}' + os.linesep * 2)

            exam_file.write(u'' + os.linesep * 2)


main()
