-- 1)
Create Database Academy
Use Academy
-- 2)
Create Table Groups
(
	Id int primary key identity,
	Name nvarchar(25) unique
)
Create Table Students(
	Id int primary key identity,
	FirstName nvarchar(25),
	SurName nvarchar(25),
	GroupId int references Groups(Id)
)
-- 3)
Alter Table Students
Add Grade int
-- 4)
Insert Into Groups(Name)
Values('P224'),
('P124'),
('P221')
Insert Into Students(FirstName,SurName,GroupId,Grade)
Values('Nicat','Aqayev','3',70),
('Eli','Veliyev','1',20),
('Veli','Eliyev','1',56),
('Ferid','Samxalov','1',68)
-- 5)
Select *
From Students Where Students.GroupId = 1
-- 6)
Select g.Name,COUNT(g.Id)
From Groups g
join Students s
on g.Id = s.GroupId
Group by g.Name,g.Id

-- 7)
Create View usv_StudName_GroupName_StudSur_StudGrade
As
Select 
s.FirstName,g.Name,s.SurName,s.Grade
From Groups g
Join Students s
on g.Id = s.GroupId
Select * from usv_StudName_GroupName_StudSur_StudGrade

-- 8)
Create Procedure usp_getStuds
@Grade int
As
Begin 
Select 
s.Id,s.FirstName,s.SurName,s.Grade,s.GroupId
From Students s
Where s.Grade > @Grade
End

exec usp_getStuds 30

-- 9)
create function get_CountStud
(
	@GroupName nvarchar(25)
)
returns int 
as  
begin 
Declare @Count int 

Select @Count = COUNT(s.FirstName)
From Groups g
join Students s
on g.Id = s.GroupId
where g.Name=@GroupName
Group by g.Name

return @Count
end 

select dbo.get_CountStud('P224')

