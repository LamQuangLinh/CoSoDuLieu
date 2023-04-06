/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: 04/04/2023
*/	

---------------------------------------------------
-----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------

create database Lab07_QLSV
go
use Lab07_QLSV
go

create table Khoa
(MSKhoa char(02) primary key,
TenKhoa nvarchar(30),
TenTat char(4)
)
go

create table Lop
(MSLop char(4) primary key,
TenLop nvarchar(30),
MSKhoa char(2) references Khoa(MSKhoa),
NienKhoa int
)
go

create table Tinh
(MSTinh char(2) primary key,
TenTinh nvarchar(20)
)
go

create table MonHoc
(MSMH char(4) primary key,
TenMH nvarchar(20),
HeSo int
)
go

create table SinhVien
(MSSV char(7) primary key,
Ho nvarchar(20),
Ten nvarchar(10),
NgaySinh date,
MSTinh char(2) references Tinh(MSTinh),
NgayNhapHoc date,
MSLop char(4) references Lop(MSLop),
Phai char(3),
DiaChi nvarchar(40),
DienThoai char(10)
)
go

create table BangDiem
(MSSV char(7) references SinhVien(MSSV),
MSMH char(4),
LanThi int,
Diem float(1)
)
go

-------------------------------------------------
-------------NHẬP DỮ LIỆU CHO CÁC BẢNG-----------
insert into Khoa values ('01',N'Công nghệ thông tin','CNTT')
insert into Khoa values ('02',N'Điện tử viễn thông','DTVT')
insert into Khoa values ('03',N'Quản trị kinh doanh','QTKD')
insert into Khoa values ('04',N'Công nghệ sinh học','CNSH')

insert into Lop values ('98TH',N'Tin hoc khoa 1998','01',1998)
insert into Lop values ('98VT',N'Vien thong khoa 1998','02',1998)
insert into Lop values ('99TH',N'Tin hoc khoa 1999','01',1999)
insert into Lop values ('99VT',N'Vien thong khoa 1999','02',1999)
insert into Lop values ('99QT',N'Quan tri khoa 1999','03',1999)

insert into Tinh values ('01',N'An Giang')
insert into Tinh values ('02',N'TPHCM')
insert into Tinh values ('03',N'Dong Nai')
insert into Tinh values ('04',N'Long An')
insert into Tinh values ('05',N'Hue')
insert into Tinh values ('06',N'Ca Mau')

insert into MonHoc values ('TA01',N'Nhap mon tin hoc',2)
insert into MonHoc values ('TA02',N'Lap trinh co ban',3)
insert into MonHoc values ('TB01',N'Cau truc du lieu',2)
insert into MonHoc values ('TB02',N'Co so du lieu',2)
insert into MonHoc values ('QA01',N'Kinh te vi mo',2)
insert into MonHoc values ('QA02',N'Quan tri chat luong',3)
insert into MonHoc values ('VA01',N'Dien tu co ban',2)
insert into MonHoc values ('VA02',N'Mach so',3)
insert into MonHoc values ('VB01',N'Truyen so lieu',3)
insert into MonHoc values ('XA01',N'Vat ly dai cuong',2)

set dateformat dmy
insert into SinhVien values ('98TH001',N'Nguyen Van',N'An','06/08/80','01','03/09/98','98TH','Yes',N'12 Tran Hung Dao, Q.1','8234512')
insert into SinhVien values ('98TH002',N'Le Thi',N'An','17/10/79','01','03/09/98','98TH','No',N'23 CMT8, Q.Tan Binh','0303234342')
insert into SinhVien values ('98VT001',N'Nguyen Duc',N'Binh','25/11/81','02','03/09/98','98VT','Yes',N'245 Lac Hong Quan, Q.11','8654323')
insert into SinhVien values ('98VT002',N'Tran Ngoc',N'Anh','19/08/80','02','03/09/98','98VT','No',N'242 Tran Hung Dao, Q.1','')
insert into SinhVien values ('99TH001',N'Ly Van Hung',N'Dung','27/08/81','03','05/10/99','99TH','Yes',N'178 CMT8, Q.Tan Binh','7563213')
insert into SinhVien values ('99TH002',N'Van Minh',N'Hoang','01/01/81','04','05/10/99','99TH','Yes',N'272 Ly Thuong Kiet, Q.10','8341234')
insert into SinhVien values ('99TH003',N'Nguyen',N'Tuan','12/01/80','03','05/10/99','99TH','Yes',N'162 Tran Hung Dao, Q.5','')
insert into SinhVien values ('99TH004',N'Tran Van',N'Minh','25/06/81','04','05/10/99','99TH','Yes',N'147 Dien Bien Phu, Q.3','7236754')
insert into SinhVien values ('99TH005',N'Nguyen Thai',N'Minh','01/01/80','04','05/10/99','99TH','Yes',N'345 Le Dai Hanh, Q.11','')
insert into SinhVien values ('99VT001',N'Le Ngoc',N'Mai','21/06/82','01','05/10/99','99VT','No',N'129 Tran Hung Dao, Q.1','0903124534')
insert into SinhVien values ('99QT001',N'Nguyen Thi',N'Oanh','19/08/73','04','05/10/99','99QT','No',N'76 Hung Vuong, Q.5','0901656324')
insert into SinhVien values ('99QT002',N'Le My',N'Hanh','20/05/76','04','05/10/99','99QT','No',N'12 Pham Ngoc Thach, Q.3','')

insert into BangDiem values ('98TH001','TA01',1,8.5)
insert into BangDiem values ('98TH001','TA02',1,8)
insert into BangDiem values ('98TH002','TA01',1,4)
insert into BangDiem values ('98TH002','TA01',2,5.5)
insert into BangDiem values ('98TH001','TB01',1,7.5)
insert into BangDiem values ('98TH002','TB01',1,8)
insert into BangDiem values ('98VT001','VA01',1,4)
insert into BangDiem values ('98VT001','VA01',2,5)
insert into BangDiem values ('98VT002','VA02',1,7.5)
insert into BangDiem values ('99TH001','TA01',1,4)
insert into BangDiem values ('99TH001','TA01',2,6)
insert into BangDiem values ('99TH001','TB01',1,6.5)
insert into BangDiem values ('99TH002','TB01',1,10)
insert into BangDiem values ('99TH002','TB02',1,9)
insert into BangDiem values ('99TH003','TA02',1,7.5)
insert into BangDiem values ('99TH003','TB01',1,3)
insert into BangDiem values ('99TH003','TB01',2,6)
insert into BangDiem values ('99TH003','TB02',1,8)
insert into BangDiem values ('99TH004','TB02',1,2)
insert into BangDiem values ('99TH004','TB02',2,4)
insert into BangDiem values ('99TH004','TB02',3,3)
insert into BangDiem values ('99QT001','QA01',1,7)
insert into BangDiem values ('99QT001','QA02',1,6.5)
insert into BangDiem values ('99QT002','QA01',1,8.5)
insert into BangDiem values ('99QT002','QA02',1,9)

select * from Khoa
select * from Lop
select * from Tinh
select * from MonHoc
select * from SinhVien
select * from BangDiem

-------------------------------------------------
----------------TRUY VẤN DỮ LIỆU-----------------
--1)
select A.MSSV, A.Ho, A.Ten, A.DiaChi
from SinhVien A

--2)
select A.MSSV, A.Ho, A.Ten, A.MSTinh
from SinhVien A
group by A.MSTinh, A.MSSV, A.Ho, A.Ten

--3)
select A.MSSV, A.Ho, A.Ten, A.NgaySinh, A.MSTinh, A.NgayNhapHoc, A.MSLop, A.Phai, A.DiaChi, A.DienThoai
from SinhVien A, Tinh B
where A.MSTinh = B.MSTinh and A.Phai = '%No%' and B.TenTinh = N'%Long An%' 

--4)
select *
from SinhVien A
where Month(A.NgaySinh) = '01'

--5)
select *
from SinhVien A
where Month(A.NgaySinh) = 1 and Day(A.NgaySinh) = 1

--6)
select *
from SinhVien A
where A.MSSV not in 
(select A.MSSV
from SinhVien A
where A.DienThoai = '' )

--7)
select *
from SinhVien A
where A.DienThoai  LIKE '0%' and A.MSSV not in 
(select A.MSSV
from SinhVien A
where A.DienThoai = '')

--8)
select *
from SinhVien A
where A.Ten = N'Minh' and left(A.MSLop,4) = '99TH' 

--9)
select *
from SinhVien A
where A.DiaChi like N'%Tran Hung Dao%'

--10)
select *
from SinhVien A
where A.Ho like '% Van'

--11)
select A.MSSV, A.Ho +' ' +A.Ten as HoTen, datediff(yy,A.NgaySinh,A.NgayNhapHoc) as Tuoi
from SinhVien A, Tinh B
where A.MSTinh = B.MSTinh and B.TenTinh = N'Long An'

--12)
select  A.MSSV, A.Ho +' ' +A.Ten as HoTen, datediff(yy,A.NgaySinh,A.NgayNhapHoc) as Tuoi
from SinhVien A
where datediff(yy,A.NgaySinh,A.NgayNhapHoc) > 23 and datediff(yy,A.NgaySinh,A.NgayNhapHoc) < 28 and A.Phai = 'Yes'

--13)
select *
from SinhVien A
where datediff(yy,A.NgaySinh,A.NgayNhapHoc) >=
Case when A.Phai = 'Yes' then 32
	when A.Phai = 'No' then 26
end; 

--14)
select *
from SinhVien A
where datediff(yy,A.NgaySinh,A.NgayNhapHoc) < 18 or datediff(yy,A.NgaySinh,A.NgayNhapHoc) > 25

--15)
select *
from SinhVien A
where left(A.MSSV,2) = '99'

--16)
select A.MSSV
from BangDiem A, SinhVien B
where A.MSSV = B.MSSV and A.LanThi = 1 and B.MSLop = '99TH' and A.MSMH = 'TB02'

--17)
select A.MSSV
from SinhVien A, BangDiem B
where A.MSSV = B.MSSV and A.MSLop = '99TH' and B.LanThi = 1 and B.MSMH = 'TB02' and B.Diem < 5 

--18)
select A.MSMH, B.TenMH, A.LanThi, A.Diem
from BangDiem A, MonHoc B
where A.MSMH = B.MSMH and A.MSSV = '99TH001'

--19)
select A.MSSV, Ho+' '+Ten as HoTen, A.MSLop
from SinhVien A, BangDiem B
where A.MSSV = B.MSSV and B.LanThi = 1 and B.Diem >= 8 and B.MSMH = 'TB02'

--20)
select *
from Tinh A
where A.MSTinh not in
(select B.MSTinh
from SinhVien A, Tinh B
where A.MSTinh = B.MSTinh)

--21)
select *
from SinhVien A
where A.MSSV not in
(select A.MSSV
from SinhVien A, BangDiem B
where A.MSSV = B.MSSV and B.Diem > 0
group by A.MSSV)

--22)
select A.MSLop, B.TenLop, count(A.MSSV) as SoLuongSV
from SinhVien A, Lop B
where A.MSLop = B.MSLop
group by A.MSLop, B.TenLop

--23)
select A.MSTinh, B.TenTinh, (select A.MSSV as SoSVNam from SinhVien A where A.Phai = 'Yes')
from SinhVien A, Tinh B
where A.MSTinh = B.MSTinh 
group by  A.MSTinh, B.TenTinh

--24)
select c.MSLop, b.TenLop,
count(case when a.Diem > 5 then null else 1 end) as 'Số SV đạt',
cast(cast(count(case when a.Diem < 5 then null else 1 end) as float)*100 /count(a.Diem) as float) as 'Tỉ lệ đạt(%)',
count(case when a.Diem > 5 then null else 1 end) as 'Số SV không đạt',
cast(cast(count(case when a.Diem > 5 then null else 1 end) as float)*100 /count(a.Diem) as float) as'Tỉ lệ không đạt(%)'

from BangDiem a, Lop b, SinhVien c, MonHoc d
where c.MSLop= b.MSLop		
and c.MSSV = a.MSSV 
and a.LanThi = '1' 
and a.MSMH = d.MSMH 
and TenMH ='Co so du lieu'
group by c.MSLop, TenLop

--25)
select A.MSSV, A.MSMH, B.TenMH, B.HeSo, max(A.Diem) as Diem, max(A.Diem)*HeSo
from BangDiem A, MonHoc B
where A.MSMH = B.MSMH 
group by A.MSMH, A.MSSV, B.TenMH, B.HeSo

--26)
select A.MSSV, Ho, Ten, (sum(Diem*HeSo)/sum(HeSo)) as DTB 
from SinhVien A, BangDiem B, MonHoc C
where A.MSSV = B.MSSV and B.MSMH = C.MSMH
group by A.MSSV, Ho, Ten

--27)
select B.NienKhoa, A.MSKhoa, A.TenKhoa, count(C.MSSV) as SoLuongSV
from Khoa A, Lop B, SinhVien C, Tinh D
where A.MSKhoa = B.MSKhoa and B.MSLop = C.MSLop and C.MSTinh = D.MSTinh and D.TenTinh = N'Long An'
group by B.NienKhoa, A.MSKhoa, A.TenKhoa

-------------------------------------------------
----------------THỦ TỤC & HÀM--------------------
--28)
create proc usp_InBangDiemSV
@MaSV char(7)
as
begin
	if exists (select * from SinhVien where MSSV = @MaSV)
		begin
			select B.MSMH, TenMH, HeSo, max(Diem) as Diem
			from SinhVien A, MonHoc B, BangDiem C
			where A.MSSV = C.MSSV and C.MSMH = B.MSMH and A.MSSV = @MaSV
			group by B.MSMH, TenMH, HeSo
		end
	else
		print N'Không tồn tại sinh viên' + @MaSV
end
------Thử nghiệm hàm-------
exec usp_InBangDiemSV '99TH004'

--29)
create proc usp_InBangDiem
@MSLop char(4)
as
begin
	if exists(select * from Lop where MSLop = @MSLop) 
		begin
			select B.MSSV, Ho, Ten, sum(Diem * HeSo)/sum(HeSo) as DTB
			from Lop A, SinhVien B, MonHoc C, BangDiem D
			where A.MSLop = B.MSLop and B.MSSV = D.MSSV and D.MSMH = C.MSMH and A.MSLop = @MSLop 
			group by B.MSSV, Ho, Ten
		end
	else
		print N'Lớp ' + @MSLop +N' không tồn tại'
end
------Thử nghiệm hàm-------
exec usp_InBangDiem '98TH' 

----Cap Nhat Du Lieu---
--30
select *
into SinhVienTinh
from Sinhvien
where MSTinh<>'02'

alter table SinhVienTinh
	add HocBong int

--31
UPDATE SinhVienTinh
SET HocBong = 10000;
SELECT * FROM SinhVienTinh;
--32
UPDATE SinhVienTinh
SET HocBong = HocBong * 1.1
WHERE Phai = 'No';

SELECT *
FROM SinhVienTinh
ORDER BY Phai;
--33
DELETE
FROM SinhVienTinh
WHERE MSTinh =
    (SELECT MSTinh
     FROM Tinh
     WHERE TenTin = 'Long An');

SELECT *
FROM SinhVienTinh;