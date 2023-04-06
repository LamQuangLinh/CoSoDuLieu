/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/
CREATE DATABASE Lab03_QLNXHH -- lenh khai bao CSDL
go
use Lab03_QLNXHH
go

create table HangHoa
(MaHH	nvarchar(5) primary key,		 
TenHH	nvarchar(50) not null unique,
DVT  nvarchar(3),
SoLuongTon int,
)
go
create table DoiTac
(MaDT nvarchar(5) primary key,
TenDT nvarchar(30) not null,
DiaChi nvarchar(30) not null,
DienThoai int,
)
go
create table KhaNangCC
(MaDT nvarchar(5) references DoiTac(MaDT),
MaHH nvarchar(5), 
primary key(MADT,MAHH),
)
go
create table HoaDon
(SoHD nvarchar(5) primary key,
NgayLapHD datetime,
MaDT nvarchar(5) references DoiTac(MaDT),
TongTG int,
)
go

create table CT_HoaDon
(
SoHD nvarchar(5) references HoaDon(SoHD),
MaHH nvarchar(5) references HangHoa(MaHH),
DonGia int,
SoLuong int,
primary key (SoHD, MaHH),

)
go
-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhập dữ liệu cho bảng hàng hóa
insert into HangHoa values('CPU01','CPU INTEL,CELERON 600 BOX',N'CÁI',5)
insert into HangHoa values('CPU02','CPU INTEL,PIII 700',N'CÁI',10)
insert into HangHoa values('CPU03','CPU AMD K7 ATHL,ON 600',N'CÁI',8)
insert into HangHoa values('HDD01','HDD 10.2 GB QUANTUM',N'CÁI',10)
insert into HangHoa values('HDD02','HDD 13.6 GB SEAGATE',N'CÁI',15)
insert into HangHoa values('HDD03','HDD 20 GB QUANTUM',N'CÁI',6)
insert into HangHoa values('KB01','KB GENIUS',N'CÁI',12)
insert into HangHoa values('KB02','KB MITSUMIMI',N'CÁI',5)
insert into HangHoa values('MB01','GIGABYTE CHIPSET INTEL',N'CÁI',10)
insert into HangHoa values('MB02','ACOPR BX CHIPSET VIA',N'CÁI',10)
insert into HangHoa values('MB03','INTEL PHI CHIPSET INTEL',N'CÁI',10)
insert into HangHoa values('MB04','ECS CHIPSET SIS',N'CÁI',10)
insert into HangHoa values('MB05','ECS CHIPSET VIA',N'CÁI',10)
insert into HangHoa values('MNT01','SAMSUNG 14" SYNCMASTER',N'CÁI',5)
insert into HangHoa values('MNT02','LG 14"',N'CÁI',5)
insert into HangHoa values('MNT03','ACER 14"',N'CÁI',8)
insert into HangHoa values('MNT04','PHILIPS 14"',N'CÁI',6)
insert into HangHoa values('MNT05','VIEWSONIC 14"',N'CÁI',7)
--xem bảng hàng hóa
select * from HangHoa
--delete from HangHoa


--Nhập bảng đối tác
insert into DoiTac values('CC001',N'Cty TNC',N'176 BTX Q1 - Tp.HCM','088250259')
insert into DoiTac values('CC002',N'Cty Hoàng Long',N'15A TTT Q1 - Tp.HCM','088250898')
insert into DoiTac values('CC003',N'Cty Hợp Nhất',N'152 BTX Q1 - Tp.HCM','088252376')
insert into DoiTac values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt','063831129')
insert into DoiTac values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert into DoiTac values('K0003',N'Trần Nhật Duật',N'Lê Lợi Tp.Huế','054848376')
insert into DoiTac values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa Tp.Đà Lạt','063823409')

--xem bảng tổ đối tác
select * from DoiTac
--delete  from DoiTac

--Nhập bảng khả năng cung cấp
insert into KhaNangCC values('CC001','CPU01')
insert into KhaNangCC values('CC001','HDD03')
insert into KhaNangCC values('CC001','KB01')
insert into KhaNangCC values('CC001','MB02')
insert into KhaNangCC values('CC001','MB04')
insert into KhaNangCC values('CC001','MNT01')
insert into KhaNangCC values('CC002','CPU01')
insert into KhaNangCC values('CC002','CPU02')
insert into KhaNangCC values('CC002','CPU03')
insert into KhaNangCC values('CC002','KB02')
insert into KhaNangCC values('CC002','MB01')
insert into KhaNangCC values('CC002','MB05')
insert into KhaNangCC values('CC002','MNT03')
insert into KhaNangCC values('CC003','HDD01')
insert into KhaNangCC values('CC003','HDD02')
insert into KhaNangCC values('CC003','HDD03')
insert into KhaNangCC values('CC003','MB03')

--xem bảng tổ khả năng cung cấp
select * from KhaNangCC

set dateformat dmy
go
--Nhập bảng hóa đơn
insert into HoaDon values('N0001','25/01/2006','CC001', null)
insert into HoaDon values('N0002','01/05/2006','CC002', null)
insert into HoaDon values('X0001','12/05/2006','K0001', null)
insert into HoaDon values('X0002','16/06/2006','K0002', null)
insert into HoaDon values('X0003','20/04/2006','K0001', null)

--xem bảng hóa đơn
select * from HoaDon
--delete  from HoaDon where SOHD ='N0002'

--Nhập bảng CT_HoaDon
insert into CT_HoaDon values('N0001','CPU01',63,10)
insert into CT_HoaDon values('N0001','HDD03',97,7)
insert into CT_HoaDon values('N0001','KB01',3,5)
insert into CT_HoaDon values('N0001','MB02',57,5)
insert into CT_HoaDon values('N0001','MNT01',112,3)
insert into CT_HoaDon values('N0002','CPU02',115,3)
insert into CT_HoaDon values('N0002','KB02',5,7)
insert into CT_HoaDon values('N0002','MNT03',111,5)
insert into CT_HoaDon values('X0001','CPU01',67,2)
insert into CT_HoaDon values('X0001','HDD03',100,2)
insert into CT_HoaDon values('X0001','KB01',5,2)
insert into CT_HoaDon values('X0001','MB02',62,1)
insert into CT_HoaDon values('X0002','CPU01',67,1)
insert into CT_HoaDon values('X0002','KB02',7,3)
insert into CT_HoaDon values('X0002','MNT01',115,2)
insert into CT_HoaDon values('X0003','CPU01',67,1)
insert into CT_HoaDon values('X0003','MNT03',115,2)
--Xem bảng CT_Hóa đơn
select * from CT_HoaDon
--delete from CT_HoaDon where SOHD ='N0002'

--Liệt kê các mặt hàng thuộc loại đĩa cứng--
select * from HANGHOA where MAHH like 'HDD%'

--Liệt kê các mặt hàng có số lượng tồn trên 10--
select * from HANGHOA where SOLUONGTON > 10

--Cho biết thông tin về các nhà cung cấp ở Thành Phố Hồ Chí Minh--
select * from DOITAC where DIACHI like '%TP%HCM%'

--Liệt kê các hóa đơn nhập hàng 5/2006--
SELECT HOADON.SOHD, HOADON.NGAYLAPHD , DOITAC.TENDT  , DOITAC.DIACHI  , DOITAC.DIENTHOAI AS DoiTac
FROM HOADON,DOITAC
where MONTH(HOADON.NGAYLAPHD)='05' and YEAR(HOADON.NGAYLAPHD)='2006' and HOADON.MADT = DOITAC.MADT  

--Cho biết tên nhà cung cấp đĩa cứng--
select * from KHANANGCC where MAHH like 'HDD%'

--Cho biết cửa hàng bán bao nhiêu mặt hàng--


--Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp--
select DOITAC.MADT as MaDoiTac, DOITAC.TENDT as TenDoiTac, COUNT(KHANANGCC.MADT) as SoLuongMatHang
from DOITAC,KHANANGCC
where DOITAC.MADT=KHANANGCC.MADT 
group by DOITAC.MADT, DOITAC.TENDT

--Tính tổng doanh thu năm 2006--
select CT_HOADON.SOHD, SUM(CT_HOADON.DONGIA) as TongDoanhThu
from CT_HOADON
group by CT_HOADON.SOHD
