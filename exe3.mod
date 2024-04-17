set STUDENTS;
set EXAMS;
set STUDENT_EXAMS {STUDENTS} within STUDENTS;

param avaiable_periods;

var schedule {EXAMS} >= 1, <= avaiable_periods integer; # day of exam
var shortest_interval {STUDENTS} >= 0, <= avaiable_periods integer;
var overlaps >= 0 integer;

maximize minInterval: min({s in STUDENTS : card(STUDENT_EXAMS[s]) > 1} if (shortest_interval[s] != 0) then shortest_interval[s] else 6969);

# Constraints
OVERLAPS:
    overlaps = sum {s in STUDENTS, d in 1 .. avaiable_periods} max(0, -1 + count {e in STUDENT_EXAMS[s]} (schedule[e] = d));

SHORTEST_INTERVAL {s in STUDENTS}:
    shortest_interval[s] = if (card(STUDENT_EXAMS[s]) > 1) then
                                min {e1 in STUDENT_EXAMS[s], e2 in STUDENT_EXAMS[s] : e1 != e2} abs(schedule[e1] - schedule[e2])
                           else
                                0;

COUNT_OVERLAPS:
    overlaps <= 0;
