set STUDENTS;
set EXAMS;
set STUDENT_EXAMS {STUDENTS} within STUDENTS;

param avaiable_periods;

var schedule {EXAMS} >= 1, <= avaiable_periods integer; # day of exam
var shortest_interval {STUDENTS} integer >= 0, <= avaiable_periods;
var overlaps >= 0 integer;

maximize sumIntervals: sum {s in STUDENTS} shortest_interval[s];

# Constraints
OVERLAPS:
    overlaps = sum {s in STUDENTS, d in 1 .. avaiable_periods} max(0, -1 + count {e in STUDENT_EXAMS[s]} (schedule[e] = d));

SHORTEST_INTERVAL {s in STUDENTS}:
    shortest_interval[s] = if (card(STUDENT_EXAMS[s]) > 1) then
                                min {e1 in STUDENT_EXAMS[s], e2 in STUDENT_EXAMS[s] : e1 != e2} abs(schedule[e1] - schedule[e2])
                           else
                                0;

COUNT_OVERLAPS:
    overlaps <= 2;
