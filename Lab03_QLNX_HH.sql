/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: 06/04/2023
*/	

create database Lab03_QLNX_HH
go
use Lab03_QLNX_HH
go

create table HangHoa(
MAHH nchar(10) primary key,TENHH nchar(50),DVT nvarchar(5),SOLUONGTON tinyint
)
go
create table DoiTac(
MADT nchar(10) primary key, TENDT nvarchar(50),DIACHI nvarchar(50),DIENTHOAI char(12)
)
go
create table HoaDon(
SOHD nchar(10) primary key, NGAYLAPHD datetime,MADT nchar(10) references DoiTac(MADT),TONGTG int null
)
go
create table KhaNangCC(
MADT nchar(10) references DoiTac(MADT),MAHH nchar(10) references HangHoa(MAHH)
)
go
create table CT_HoaDon(
SOHD nchar(10) references HoaDon(SOHD), MAHH nchar(10) references HangHoa(MAHH), DONGIA tinyint,SOLUONG tinyint
)
go

insert into HangHoa values	('CPU01','CPU INTEL, CELERON 600 BOX','CÁI',5),
							('CPU02','CPU INTEL,PIII 700','CÁI',10),
							('CPU03','CPU AMD K7 ATHL,ON 600','CÁI',8),
							('HDD01','HDD 10.2 GB QUANTUM','CÁI',10),
							('HDD02','HDD 13.6 GB SEAGATE','CÁI',15),
							('HDD03','HDD 20 GB QUANTUM','CÁI',6),
							('KB01','KB GENIUS','CÁI',12),
							('KB02','KB MITSUMIMI','CÁI',5),
							('MB01','KBGIGABYTECHIPSET INTEL','CÁI',10),
							('MB02','ACORP BX CHIPSET VIA','CÁI',10),
							('MB03','INTEL PHI CHIPSET INTEL','CÁI',10),
							('MB04','ECS CHIPSET SIS','CÁI',10),
							('MB05','ECS CHIPSET VIA','CÁI',10),
							('MNT01','SAMSUNG 14" SYNCMASTER','CÁI',5),
							('MNT02','LG 14"','CÁI',5),
							('MNT03','ACER 14"','CÁI',8),
							('MNT04','PHILIPS 14"','CÁI',6),
							('MNT05','VIEWSONIC 14"','CÁI',7)
	
SELECT *FROM HangHoa
SET DATEFORMAT DMY

INSERT INTO DoiTac VALUES	('CC001',N'Cty TNC','176 BTX Q1 - TPHCM','08.8250259'),
							('CC002',N'Cty Hoàng Long','15A TTT Q1 - TP.HCM','08.8250898'),
							('CC003',N'Cty Hợp Nhất','152 BTX Q1 - TP.HCM','08.8252376'),
							('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp. Đà Lạt','063.831129'),
							('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270'),
							('K0003',N'Trần nhật Duật',N'Lê Lợi TP.Huế','054.848376'),
							('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi nghĩa - TP. Đà Lạt','063.823409')
SELECT *FROM DoiTac
INSERT INTO HoaDon VALUES ('N0001','25/01/2006','CC001',' '),
						  ('N0002','01/05/2006','CC002',' '),
						  ('X0001','12/05/2006','K0001',' '),
						  ('X0002','16/06/2006','K0002',' '),
						  ('X0003','20/04/2006','K0001',' ')
SELECT *FROM HoaDon

delete from KhaNangCC

insert into KhaNangCC values ('CC001','CPU01'),
							 ('CC001','HDD03'),
							 ('CC001','KB01'),
							 ('CC001','MB02'),
							 ('CC001','MB04'),
							 ('CC001','MNT01'),
							 ('CC002','CPU01'),
							 ('CC002','CPU02'),
							 ('CC002','CPU03'),
							 ('CC002','KB02'),
							 ('CC002','MB01'),
							 ('CC002','MB05'),
							 ('CC002','MNT03'),
							 ('CC003','HDD01'),
							 ('CC003','HDD02'),
							 ('CC003','HDD03'),
							 ('CC003','MB03')
select *from KhaNangCC

insert into	CT_HoaDon values ('N0001','CPU01',63,10),
							 ('N0001','HDD03',97,7),
							 ('N0001','KB01',3,5),
							 ('N0001','MB02',57,5),
							 ('N0001','MNT01',112,3),
							 ('N0002','CPU02',115,3),
							 ('N0002','KB02',5,7),
							 ('N0002','MNT03',111,5),
							 ('X0001','CPU01',67,2),
							 ('X0001','HDD03',100,2),
							 ('X0001','KB01',5,2),
							 ('X0001','MB02',62,1),
							 ('X0002','CPU01',67,1),
							 ('X0002','KB02',7,3),
							 ('X0002','MNT01',115,2),
							 ('X0003','CPU01',67,1),
							 ('X0003','MNT03',115,2)

select *from CT_HoaDon
-- câu 1
select a.MAHH,a.TENHH,a.DVT,a.SOLUONGTON from HangHoa a where a.MAHH like 'HDD%'
-- câu 2
select a.MAHH,a.TENHH,a.DVT,a.SOLUONGTON from HangHoa a where a.SOLUONGTON >10
-- Câu 3
select a.MADT,a.TENDT,a.DIACHI,a.DIENTHOAI from DoiTac a where a.DIACHI like '%HCM'
-- Câu 4
select distinct a.SOHD,a.NGAYLAPHD,b.TENDT,b.DIACHI,b.DIENTHOAI,c.SOLUONG  from HoaDon a, DoiTac b,CT_HoaDon c where a.SOHD =c.SOHD and b.MADT=a.MADT  and a.SOHD like 'N000%'  and MONTH(a.NGAYLAPHD)='05'and YEAR(a.NGAYLAPHD)='2006'
-- Câu 5
select distinct a.MAHH,a.MADT,b.TENDT,b.DIACHI,b.DIENTHOAI from KhaNangCC a,DoiTac b where a.MADT=b.MADT and a.MAHH like 'HDD%'
-- Câu 6
-- Tên nhà cc có thể cung cấp tất cả các loại đĩa cứng
SELECT MADT, COUNT(MAHH) AS SLHH
FROM KhaNangCC B
WHERE MAHH LIKE 'HDD%'
GROUP BY MADT
HAVING COUNT (MAHH) = (SELECT COUNT(MAHH)
					   FROM HangHoa
					   WHERE MAHH LIKE 'HDD%')
GO
select distinct a.MAHH,a.MADT, COUNT(a.MAHH) as SoLuong from KhaNangCC a,DoiTac b where a.MADT=b.MADT  and a.MAHH = 'HDD01' or a.MAHH ='HDD02'or a.MAHH = 'HDD03'  group by a.MAHH,a.MADT
-- Câu 7
select distinct a.MAHH,a.MADT,b.TENDT from KhaNangCC a,DoiTac b where a.MADT=b.MADT and a.MAHH not like 'HDD%'
-- Câu 8
select MAHH, TenHH
from HangHoa
where MaHH not in(select a.MaHH
					from CT_HoaDon a, HangHoa b
					where a.MaHH=b.MaHH
					group by a.MaHH)
-- Câu 9
select b.MAHH, b.TenHH, SUM(a.SOLUONG) as SoLuong
from CT_HoaDon a, HangHoa b
where a.MaHH=b.MaHH
group by b.MaHH, b.TenHH
having SUM(a.SOLUONG)>=all(select SUM(SOLUONG)
						from CT_HoaDon c
						group by c.MaHH)
-- Câu 10
select distinct b.MAHH, min(b.SOLUONG) as SoLuong from CT_HoaDon b where b.SOHD like 'N%'  group by b.MAHH having min(b.SOLUONG)>= all(select sum(a.SOLUONG) from CT_HoaDon a  group by a.MAHH)

-- Câu 11
select distinct a.SOHD,a.MAHH,SUM(a.SOLUONG) from CT_HoaDon a where a.SOHD like 'N%' group by a.SOHD,a.MAHH having SUM(a.SOLUONG)>= all(select SUM(b.SOLUONG) from CT_HoaDon b)
-- Câu 12
select distinct a.SOHD,a.NGAYLAPHD,b.MAHH,b.DONGIA,b.SOLUONG from HoaDon a, CT_HoaDon b where a.SOHD=b.SOHD and a.SOHD like 'N%' and MONTH(a.NGAYLAPHD) <> '01'
-- Câu 13
select distinct a.SOHD,a.NGAYLAPHD,b.MAHH,b.DONGIA,b.SOLUONG from HoaDon a, CT_HoaDon b where a.SOHD=b.SOHD and a.SOHD like 'X%' and MONTH(a.NGAYLAPHD) <> '06'

-- Câu 14
select distinct COUNT (a.MAHH) as SOLUONGHH from HangHoa a group by a.MAHH
-- Câu 15

-- Câu 16

-- Câu 17
select sum(a.SOLUONG*b.SOLUONGTON) as TongSoTien
from CT_HoaDon a, HangHoa b, HoaDon c
where a.MaHH =b.MaHH and c.SoHD=a.SoHD and a.SOHD like 'N%' and YEAR(c.NGAYLAPHD) ='2006'
-- Câu 18

select b.MaHH, b.TenHH, SUM(a.SOLUONG) as SoLuong
from CT_HoaDon a, HangHoa b
where a.MaHH=b.MaHH
group by b.MaHH, b.TenHH
having SUM(a.SOLUONG)>=all(select SUM(SOLUONG)
						from CT_HoaDon c
						group by c.MaHH)

-- Câu 19
select a.MAHH,b.TENHH,b.DVT,SUM(a.SOLUONG) as TONGSL,sum(a.SOLUONG*b.SOLUONGTON) as TongSoTien
from CT_HoaDon a, HangHoa b, HoaDon c
where a.MaHH =b.MaHH and c.SoHD=a.SoHD and a.SOHD like 'X%'
group by b.MaHH, b.TenHH,a.MAHH,b.DVT
having SUM(a.SOLUONG)>=all(select SUM(SOLUONG)
						from CT_HoaDon c
						group by c.MaHH)
-- Câu 20

-- Câu 21
