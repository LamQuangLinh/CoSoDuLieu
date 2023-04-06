/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: 06/04/2023
*/	
 create database Lab05_QLDL
 go
 use Lab05_QLTDL
 go
create table Tour(
MaTour nchar(5) primary key, TongSoNgay tinyint
)
go

create table ThanhPho(
MaTP nchar(3) primary key, TenTP nvarchar(30)
)
go
create table Tour_TP(
MaTour nchar(5) references Tour(MaTour), MaTP nchar(3) references ThanhPho(MaTP), SoNgay tinyint
)
go

create table Lich_TourDL(
MaTour nchar(5) references Tour(MaTour), NgayKH date, TenHDV nvarchar(10),SoNguoi tinyint,TenKH nvarchar(20)
)
go
set dateformat dmy

insert into Tour values ('T001',3),
						('T002',4),
						('T003',5),
						('T004',7)
go
insert into ThanhPho values ('01','Đà Lạt'),
							('02','Nha Trang'),
							('03','Phan Thiết'),
							('04','Huế'),
							('05','Đà Nẵng')
go
insert into Tour_TP values ('T001','01',2),
						   ('T001','03',1),
						   ('T002','01',2),
						   ('T002','02',2),
						   ('T003','02',2),
						   ('T003','01',1),
						   ('T003','04',2),
						   ('T004','02',2),
						   ('T004','05',2),
						   ('T004','04',3)
GO
insert into Lich_TourDL values  ('T001','14/02/2017','Vân',20,'Nguyễn Hoàng'),
								('T002','14/02/2017','Nam',30,'Lê Ngọc'),
								('T002','06/03/2017','Hùng',20,'Lý Dũng'),
								('T003','18/02/2017','Dũng',20,'Lý DŨng'),
								('T004','18/02/2017','Hùng',30,'Dũng Nam'),
								('T003','10/03/2017','Nam',45,'Nguyễn An'),
								('T002','28/04/2017','Vân',25,'Ngọc Dung'),
								('T004','29/04/2017','Dũng',25,'Lê Ngọc'),
								('T001','30/04/2017','Nam',25,'Trần Nam'),
								('T003','15/06/2017','Vân',20,'Trịnh Bá')
go
select *from Tour
select *from ThanhPho
select *from Tour_TP
select *from Lich_TourDL

-- câu 1 cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày
select distinct a.MaTour,b.TenTP,a.TongSoNgay from Tour a,ThanhPho b, Tour_TP c where a.MaTour=c.MaTour and b.MaTP=c.MaTP and a.TongSoNgay >=3 and a.TongSoNgay<=5
-- câu 2 cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017
select distinct a.MaTour,a.NgayKH,a.TenHDV,a.SoNguoi,a.TenKH from Lich_TourDL a where  MONTH(a.NgayKh)='02' and YEAR(a.NgayKH)='2017'
-- câu 3 cho biết các tour không đi qua thành phố Nha Trang
select distinct a.MaTour,b.TenTP from Tour a, ThanhPho b ,Tour_TP c where a.MaTour=c.MaTour and b.MaTP=c.MaTP and b.TenTP not like 'Nha Trang'
-- câu 4 cho biết số lượng thành phố mà mỗi tour đi qua
select distinct a.MaTour,count(a.MaTP) as SoLuongTP from Tour_TP a group by a.MaTour
-- câu 5 cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn
select distinct a.TenHDV, count(a.MaTour) as SoLuongTour from Lich_TourDL a group by a.TenHDV
-- câu 6 cho biết tên thành phố có nhiều tour đi qua nhất
select distinct a.TenTP,COUNT(b.MaTour) as TongSo from ThanhPho a, Tour_TP b where a.MaTP=b.MaTP group by a.TenTP having count(b.MaTour)>=all(select count(c.MaTour) from Tour_TP c)
-- câu 7 cho biết thông tin của tour du lịch đi qua các thành phố
select distinct c.MaTour,a.TenTP,c.NgayKH from ThanhPho a,Tour_Tp b, Lich_TourDL c where a.MaTP=b.MaTP and b.MaTour=c.MaTour
-- câu 8 lập danh sách các tour đi qua thành Đà Lạt, thông tin cần hiện thị bao gồm MaTour, SoNgay
select distinct a.MaTour,a.SoNgay from Tour_TP a where a.MaTP='01'
-- câu 9 cho biết thông tin các tour du lịch có tổng số lượng khách tham gia nhiều nhất
select distinct a.MaTour,a.NgayKH,max(a.SoNguoi),a.TenHDV,a.TenKH from Lich_TourDL a group by a.MaTour,a.NgayKH,a.TenHDV,a.TenKH having MAX(a.SoNguoi)>= all (select b.SoNguoi from Lich_TourDL b)
-- câu 10 cho biết tên thành phố mà tất cả các tour du lịch đều đi qua
select distinct a.TenTP from ThanhPho a,Tour_TP b where a.MaTP=b.MaTP group by a.TenTP,b.MaTour having COUNT(b.MaTour)=5
