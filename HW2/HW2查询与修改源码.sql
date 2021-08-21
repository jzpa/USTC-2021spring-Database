use test;
#(1)
select sno,sname from Student
where sname like '%33%';

#(2)
select cno,cname from Course
where type = 0 and credit >= 3;

#(3)
select sno,sname from Student
where sno in(
	select sno from SC
	where score is null and cno in(
		select cno from Course
        where type = 3
	)
);

#(4)
select sno,sname, timestampdiff(year,birthdate,now()) as age from Student
where birthdate < date_sub(now(),interval 20 year);

#(5)
select sno,sname from Student
where sno in(
	select sno from(
		select sno,sum(credit) as total_Credit from SC
		join Course on SC.cno = Course.cno
		where type = 0
		group by sno
        ) as Group_Sno_Credit
	where total_Credit > 16
)	and sno not in(
	select sno from SC join Course on SC.cno = Course.cno
    where type = 2 and score <= 75
);

#(6)
select sname from Student
where sno in(
	select sno from (
		select sno,count(*) as s_count from SC
        join Course on SC.cno = Course.cno
        where type = 0 and score >= 60
        group by sno
    ) as sno_count,(
		select count(*) as t_count from Course
        where type = 0
    ) as course_count
    where sno_count.s_count = course_count.t_count
);

#(7)
select Student.sno,sname,major_score,full_score from (
	select SC.sno, avg(score) as major_score ,Sno_fullScore.full_score from SC 
    inner join Course on SC.cno = Course.cno
    inner join (
		select t.sno,t.full_score from(
			select sno,avg(score) as full_score from SC
			group by sno
		) as t
        where t.full_score >= (
			select max(full_score) from(
				select sno,full_score from (
					select sno,full_score from (
						select sno,avg(score) as full_score from SC
						group by sno
					) as sno_score
					order by full_score desc
				) as t1
				where (
					select count(*) from (
						select sno,avg(score) as full_score from SC
						group by sno
					)as t2
					where t1.full_score > t2.full_score 
				) <= (select floor(count(*)/2) from Student)
			) as t3
        )
    )as sno_fullScore on SC.sno = sno_fullScore.sno
    where type = 0 
    group by SC.sno
) as sno_major_score
inner join Student on sno_major_score.sno = Student.sno
order by major_score desc
limit 10;

#(8)
select cname,type,maxGrade,minGrade,avgGrade,notPassRate from Course
inner join(
	select cno,max(score) as maxGrade,min(score) as minGrade, avg(score) as avgGrade , sum(1 - (score div 60)) / count(*) as notPassRate from SC
	group by cno
) as t on Course.cno = t.cno 
order by field(type,2,0,1,3);

#(9)
select t.sno,sname,t.cno,cname from (
	select sno,cno from SC
	group by sno,cno
	having count(*) > 1
) as t
inner join Student on t.sno = Student.sno
inner join Course on t.cno = Course.cno;

#(10)
SET SQL_SAFE_UPDATES = 0;
delete SC from SC,(
	select t1.sno,t1.cno,term from(
		select sno,cno,max(term) as term from SC 
		group by sno,cno
    ) as t1
    inner join(
		select sno,cno from SC
		group by sno,cno
		having count(*) > 1
	) as t2
    on t1.sno = t2.sno and t1.cno = t2.cno
)as t
where SC.sno = t.sno and SC.cno = t.cno and SC.term != t.term;


