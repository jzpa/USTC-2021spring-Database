use test;

# drop table SC;
# drop table Student;
# drop table Course;

create table Student (
	sno int primary key,
    sname char(10)
);
insert into Student value(0, 'S111');
insert into Student value(1, 'S222');
insert into Student value(2, 'S333');
insert into Student value(3, 'S444');
insert into Student value(4, 'S555');

create table Course (
	cno int primary key,
    cname char(10),
    type int,
    credit int
);

insert into Course value(0, 'C111', 0, 4); # 1, 4, 8
insert into Course value(1, 'C222', 0, 5); # 2, 5, 7
insert into Course value(2, 'C333', 0, 3); # 3, 6, 8
insert into Course value(3, 'C444', 0, 2); # 4

insert into Course value(4, 'C555', 1, 4); # 1, 3, 5
insert into Course value(5, 'C666', 1, 3); # 2, 4, 6
insert into Course value(6, 'C777', 1, 3); # 3, 7, 8

insert into Course value(7, 'C888', 2, 3); # 1-8
insert into Course value(8, 'C999', 2, 3); # 1-8

insert into Course value(9, 'Caaa', 3, 3); # 1-8
insert into Course value(10, 'Cbbb', 3, 1); # 1-8

create table SC (
	sno int,
    cno int,
    foreign key fk_sno(sno) references Student(sno),
    foreign key fk_cno(cno) references Course(cno),
    score int,
    term int,
    check (term >= 1 and term <= 8)
);

# term 1
insert into SC value(0, 0, 40, 1); # 第4学期重修
insert into SC value(1, 0, 51, 1); # 第8学期重修
insert into SC value(2, 0, 75, 1);
insert into SC value(3, 0, 80, 1);
insert into SC value(4, 0, 93, 1);
insert into SC value(2, 4, 70, 1);
insert into SC value(1, 9, 80, 1);

#term 2
insert into SC value(0, 1, 71, 2);
insert into SC value(1, 1, 63, 2);
insert into SC value(2, 1, 45, 2); #第5学期重修
insert into SC value(3, 1, 50, 2);
insert into SC value(4, 1, 100, 2);
insert into SC value(4, 5, 90, 2);
insert into SC value(3, 7, 57, 2);
insert into SC value(0, 10, 80, 2);

#term 3
insert into SC value(0, 2, 75, 3);
insert into SC value(1, 2, 56, 3);
insert into SC value(2, 2, 75, 3);
insert into SC value(3, 2, 10, 3); # 第6学期重修
insert into SC value(4, 2, 70, 3); # 第5学期重修
insert into SC value (1, 4, 89, 3); 
insert into SC value (0, 9, 86, 3);

# term 4
insert into SC value(0, 3, 71, 4);
insert into SC value(1, 3, 77, 4);
insert into SC value(2, 3, 75, 4);
insert into SC value(3, 3, 84, 4);
insert into SC value(4, 3, 73, 4);
insert into SC value(1, 5, 60, 4);
insert into SC value(3, 5, 87, 4);
insert into SC value(2, 8, 75, 4);

# term 5
insert into SC value(2, 1, 76, 5); 
insert into SC value(4, 2, 89, 5);
insert into SC value(0, 4, 96, 5); 
insert into SC value(2, 4, 83, 5); 

#term 6
insert into SC value(3, 2, null, 6);
insert into SC value(2, 5, 89, 6);
insert into SC value(1, 7, 66, 6);
insert into SC value(4, 8, 87, 6);

#term 7
insert into SC value(0, 6, 39, 7);
insert into SC value(1, 6, 52, 7);
insert into SC value(3, 6, 77, 7);
insert into SC value(0, 7, null, 7);

#term 8
insert into SC value(1, 0, null, 8);
insert into SC value(4, 9, 89, 8);
insert into SC value(2, 10, null, 8);
insert into SC value(3, 10, null, 8);