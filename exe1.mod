set STUDENTS;
set EXAMS;
set STUDENT_EXAMS {STUDENTS};

param avaiable_periods;

var schedule {EXAMS} >= 1, <= avaiable_periods integer; # day of exam
var overlaps >= 0 integer;

OVERLAPS:
    overlaps = sum {s in STUDENTS, d in 1 .. avaiable_periods} max(0, -1 + count {e in STUDENT_EXAMS[s]} (schedule[e] = d));

minimize z: overlaps;
