/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: 06/04/2023
*/	
create database lab02_QLXS
go

use lab02_QLXS
go

create table ToSanXuat
(
MaTSX char(5) primary key, 
TenTSX nvarchar(15) unique
)
go




create table CongNhan
(
MACN char(5) primary key, Ho nvarchar(20),Ten nvarchar(10),Phai nvarchar(4),NgaySinh datetime, MaTSX nchar(5) references ToSanXuat(MaTSX)
)


go
create table SanPham
(
MASP char(5) primary key, TenSP nvarchar(20) not null unique,DVT nchar(10) not null,TienCong int 
)

go
create table ThanhPham
(
MACN nchar(5) references CongNhan(MACN), MaSP nchar(5) references SanPham(MASP),Ngay datetime,SoLuong tinyint
)
alter table ThanhPham alter column SoLuong int
alter table ThanhPham alter column Ngay date
go


insert into ToSanXuat values ('TS01',N'Tổ 1')
insert into ToSanXuat values ('TS02',N'Tổ 2')
select *from ToSanXuat
set dateformat dmy

insert into CongNhan values ('CN001',N'Nguyễn Trường',N'An','Nam','12/05/1981','TS01')
insert into CongNhan values ('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
insert into CongNhan values ('CN003',N'Nguyễn Công',N'Thành','Nam','04/05/1981','TS02')
insert into CongNhan values ('CN004',N'Võ Hữu',N'Hạnh',N'Nam','15/02/1980','TS02')
insert into CongNhan values ('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981','TS01')

select *from CongNhan

insert into SanPham values ('SP001',N'Nồi đất','cái','10000')
insert into SanPham values ('SP002',N'Chén','cái','2000')
insert into SanPham values ('SP003',N'Bình gốm nhỏ','cái','20000')
insert into SanPham values ('SP004',N'Bình gốm lớn','cái','25000')
select *from SanPham


insert into ThanhPham values ('CN001','SP001','01/02/2007','10')
insert into ThanhPham values ('CN002','SP001','01/02/2007','5')
insert into ThanhPham values ('CN003','SP002','10/01/2007','50')
insert into ThanhPham values ('CN004','SP003','12/01/2007','10')
insert into ThanhPham values ('CN005','SP002','12/01/2007','100')
insert into ThanhPham values ('CN002','SP004','13/02/2007','10')
insert into ThanhPham values ('CN001','SP003','14/02/2007','15')
insert into ThanhPham values ('CN003','SP001','15/01/2007','20')
insert into ThanhPham values ('CN003','SP004','14/02/2007','15')
insert into ThanhPham values ('CN004','SP002','30/01/2007','100')
insert into ThanhPham values ('CN005','SP003','01/02/2007','50')
insert into ThanhPham values ('CN001','SP001','20/02/2007','30')
select *from ThanhPham

--						delete from ThanhPham

go
--Câu 1 Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen,NgaySinh,Phai (sắp tăng)
select  TenTSX, Ho+' '+Ten as HoTen, NgaySinh, Phai from ToSanXuat a, CongNhan b order by a.MaTSX asc,b.Ten asc
--------------------------------------------------------------------------------------------------------
-- Câu 2  Liệt kê các sản phẩm mà công nhân 'Nguyễn Trường An' làm được gồm các thông tin: TenSP, Ngay, SoLuong, ThanhTien (tang theo ngay)
select distinct a.TenSP,b.Ngay,b.SoLuong,b.SoLuong*a.TienCong as ThanhTien from  SanPham a, ThanhPham b, CongNhan c where b.MaSP=a.MASP and b.MACN like 'CN001' order by b.Ngay asc
-------------------------------------------------------------------------------------------------------------------
-- Câu 3 Liệt kê các công nhân không sản xuất "Bình gốm lớn"
select distinct CongNhan.MACN, CongNhan.Ho+CongNhan.Ten as HoTen,CongNhan.NgaySinh,CongNhan.MaTSX,SanPham.TenSP from CongNhan, SanPham,ThanhPham
where SanPham.MASP=ThanhPham.MaSP and ThanhPham.MaSP!='SP004'
-----------------------------------------------------------------------------------------------------------------------------------
-- câu 4 liệt kê thông tin các nhân viên có sản xuất nồi đất và bình gốm nhỏ
select distinct a.MACN, a.Ho+a.Ten as HoTen,c.TenSP 
from CongNhan a, ThanhPham b, SanPham c
where a.MACN=b.MACN and b.MASP=c.MaSP and b.MaSP='SP003' and a.MACN in
(
select d.MACN 
from ThanhPham d, SanPham e 
where d.MaSP=e.MASP and d.MaSP='SP001'
)
group by a.MACN, Ho,Ten,c.TenSP
---------------------------------------------------------------------------------------------------------------------------------------
-- Câu 5 Thống kê số lượng công nhân theo từng tổ sản xuất
select distinct a.TenTSX, count(b.MACN) as SoLuong from ToSanXuat a, CongNhan b where a.MaTSX=b.MaTSX group by a.TenTSX
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Câu 6 Thống kê số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được gồm: Ho,Ten,TenSP,TongSLThanhPham,TongThanhTien
select distinct a.Ho+a.Ten as HoTen, b.TenSP, sum(SoLuong) as TongSLThanhPham, SUM((b.TienCong*c.SoLuong)) as TongThanhTien from CongNhan a, SanPham b, ThanhPham c where a.MACN=c.MACN and b.MASP=c.MaSP group by a.Ho,a.Ten,b.TenSP
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Cau 7 Tong so tien cong da tra cho cong nhan trong 1/2007
select distinct sum((b.SoLuong*c.TienCong)) as TongTienCong  from ThanhPham b, SanPham c where b.MaSP=c.MASP and MONTH(b.ngay)='01' and year(b.ngay)= '2007'
-----------------------------------------------------------------------------------------------------------------------------

--Câu 8 cho biết sản phẩm được sản xuất nhiều nhất trong tháng 1 năm 2007
Select		SanPham.TenSP, SUM(SoLuong) as SoLuongSP 
From		SanPham,ThanhPham
Where		SanPham.MASP = ThanhPham.MaSP
Group by	TenSP
Having		SUM(SoLuong) >=all (select	SUM(SoLuong)
						   From	ThanhPham
						   Where MONTH(Ngay) = 02 and YEAR(Ngay) = 2007
						   Group by	SoLuong)
--------------------------------------------------------------------------------------------------------------------------------
-- câu 9 cho biết công nhân sản xuất được nhiêu chén nhất
Select		Ho +' '+Ten as HoTen, SUM(SoLuong) as SoLuongSP 
From		SanPham, ThanhPham, CongNhan
Where		CongNhan.MACN = ThanhPham.MACN
Group by	Ho +' '+Ten
Having		SUM(SoLuong) >=all (select	SUM(SoLuong)
						   From	ThanhPham, SanPham
						   Where  SanPham.TenSp= N'Chen' and SanPham.DVT = ThanhPham.MaSP
						   Group by	SoLuong)
------------------------------------------------------------------------------------------------------------------
--Cau 10 Tong so tien cong 02/2006 cua cong nhan co ma so "CN002"
select distinct b.MACN , sum(b.SoLuong*c.TienCong) as TongTienCong  from ThanhPham b, SanPham c where b.MACN ='CN002' and b.MaSP=c.MASP and MONTH(b.ngay)='02' and year(b.ngay)= '2006' group by b.MACN
-----------------------------------------------------------------------------------------------------------------------------
--Cau 11 liet ke cac cong nhan co san xuat tu 3 loai san pham tro len
 select CongNhan.MACN,  CongNhan.Ho, CongNhan.Ten, SUM(TienCong * SoLuong) as TongTienCongCN002
from CongNhan, SanPham, ThanhPham
where CongNhan.MACN = ThanhPham.MACN and SanPham.MASP = ThanhPham.MaSP and MONTH(Ngay) = 2 and YEAR(Ngay) = 2007 and CongNhan.MACN = 'CN002'
Group by CongNhan.MACN, CongNhan.Ho, CongNhan.Ten
----------------------------------------------------------------------------------------------------------------------------------------------------

-- cau 12 cap nhat gia tien cong cua cac loai binh gom them 1000
update SanPham set TienCong = TienCong+1000 where MASP ='SP003' or MASP ='SP004'
select *from SanPham
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- cau 13 them bo <'CN006','Le Thi','Lan','Nu',TS02'> vao bang cong nhan
insert into CongNhan values ('CN006','Lê Thị','Lan','Nữ', null,'TS02')
select *from CongNhan