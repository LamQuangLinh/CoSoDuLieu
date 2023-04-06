------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 16/03/2023
   Người thực hiện: Lâm Quang Linh
   Mã số sinh viên: 2112998
   Lab4: Quản lý dặt báo
*/
------------------------------------------------

--Tạo CSDL
CREATE DATABASE Lab04_QLDatBao
go

use Lab04_QLDatBao

--Tao bang
create table BAO_TCHI
(
MaBaoTC char(4) primary key,
TenBaoTC nvarchar(30),
DinhKy nvarchar(30),
SoLuong int,
GiaBan int,
)
go

create table PHATHANH
(
MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
SoBaoTC int,
NgayPH date,
primary key(MaBaoTC, SoBaoTC)
)
go

create table KHACHHANG
(
MaKH char(4) primary key,
TenKH nvarchar(10) not null,
DiaChi nvarchar(30)
)
go

create table DATBAO
(
MaKH char(4) references KHACHHANG(MaKH),
MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
SLMua int,
NgayDM date
primary key(MaKH, MaBaoTC)
)
go

--Xóa bảng
--drop table DATBAO
--drop table KHACHHANG
--drop table PHATHANH
--drop table BAO_TCHI

--Xem bảng
select*from BAO_TCHI
select*from PHATHANH
select*from KHACHHANG
select*from DATBAO

--Nhập bảng
insert into BAO_TCHI values('TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500)
insert into BAO_TCHI values('KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000)
insert into BAO_TCHI values('TN01', N'Thanh niên', N'Nhật báo', 1000, 2000)
insert into BAO_TCHI values('PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000)
insert into BAO_TCHI values('PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000)
insert into BAO_TCHI values('HS01', N'Báo Mới', N'Tuần báo', 1200, 2000)
select*from BAO_TCHI

set dateformat dmy
insert into PHATHANH values('TT01', 123, '15/12/2005')
insert into PHATHANH values('KT01', 70, '15/12/2005')
insert into PHATHANH values('TT01', 124, '16/12/2005')
insert into PHATHANH values('TN01', 256, '17/12/2005')
insert into PHATHANH values('PN01', 45, '23/12/2005')
insert into PHATHANH values('PN02', 111, '18/12/2005')
insert into PHATHANH values('PN02', 112, '19/12/2005')
insert into PHATHANH values('TT01', 125, '17/12/2005')
insert into PHATHANH values('PN01', 46, '30/12/2005')
insert into PHATHANH values('TN01', 56, '23/12/2005')
select*from PHATHANH
--delete from PHATHANH

insert into KHACHHANG values('KH01', N'LAN', N'2 NCT')
insert into KHACHHANG values('KH02', N'NAM', N'32 THĐ')
insert into KHACHHANG values('KH03', N'NGỌC', N'16 LHP')
select*from KHACHHANG
--delete from KHACHHANG

set dateformat dmy
insert into DATBAO values('KH01', 'TT01', 100, '12/01/2000')
insert into DATBAO values('KH02', 'TN01', 150, '01/05/2001')
insert into DATBAO values('KH01', 'PN01', 200, '25/06/2001')
insert into DATBAO values('KH03', 'KT01', 50, '17/03/2002')
insert into DATBAO values('KH03', 'PN02', 200, '26/08/2003')
insert into DATBAO values('KH02', 'TT01', 250, '15/01/2004')
insert into DATBAO values('KH01', 'KT01', 300, '14/10/2004')
insert into DATBAO values('KH03', 'TT01', 400, '17/01/2000')
select*from DATBAO

--Truy van du lieu
--1 Báo tạp chí có định kỳ phát hành hàng tuần
select MaBaoTC, TenBaoTC, GiaBan
from BAO_TCHI
where DinhKy = N'Tuần báo'

--2 Báo phụ nữ
select *
from BAO_TCHI
where MaBaoTC like 'PN%'

--3 Khách hàng đặt mua báo phụ nữ
select TenKH
from KHACHHANG A, DATBAO B
where A.MaKH = B.MaKH and MaBaoTC like 'PN%'
group by TenKH, B.MaKH

-- 4 Khách hàng đặt mua tất cả báo phụ nữ
select TenKH
from KHACHHANG A, DATBAO B
where A.MaKH = B.MaKH and MaBaoTC like 'PN%'
group by TenKH, B.MaKH
having count(B.MaBaoTC) = (select count(C.MaBaoTC)
							from BAO_TCHI C
							where MaBaoTC like 'PN%')

--insert into DATBAO values('KH03', 'PN01', 100, '26/08/2003')
--delete from DATBAO
--where MaKH = 'KH03' and MaBaoTC = 'PN01'
--select * from DATBAO

--5 Khách hàng không đặt mua báo thanh niên
select TenKH
from KHACHHANG A, DATBAO B
where A.MaKH = B.MaKH and B.MaKH not in (select C.MaKH
											from DATBAO C
											where MaBaoTC like 'TN%')
group by TenKH, B.MaKH

-- 6 Số tờ báo mỗi khách hàng đặt mua
select B.MaKH, TenKH, sum(SLMua) as TongSLMua
from DATBAO A, KHACHHANG B
where A.MaKH = B. MaKH 
group by B.MaKH, TenKH

-- 7 Số khách đặt mua báo trong năm 2004
select count(MaKH) as SoKH
from DATBAO 
where YEAR(NgayDM) = 2004

-- 8 Thông tin đặt mua báo của các khách hàng
select TenKH, TenBaoTC, Dinhky, SLMua, (SLMua*GiaBan) as SoTien
from KHACHHANG A, BAO_TCHI B, DATBAO C
where A.MaKH = C.MaKH and B.MaBaoTC = C.MaBaoTC 
group by TenKH, TenBaoTC, Dinhky, SLMua, SLMua*GiaBan

-- 9 Cho biết các tờ báo, tạp chí và tổng số lượng mua của các khách hàng đối với tờ báo, tạp chí đó
select TenKH, TenBaoTC, Dinhky, SLMua
from KHACHHANG A, BAO_TCHI B, DATBAO C
where A.MaKH = C.MaKH and B.MaBaoTC = C.MaBaoTC 
group by TenKH, TenBaoTC, Dinhky, SLMua

-- 10 Tên các tờ báo dành cho học sinh, sinh viên
select TenBaoTC
from BAO_TCHI 
where MaBaoTC like 'HS%'

--delete from BAO_TCHI
--where MaBaoTC = 'HS01' and TenBaoTC = N'Báo Mới'
--select * from BAO_TCHI

-- 11 Những tờ báo không có người đặt mua
select A.MaBaoTC, TenBaoTC
from BAO_TCHI A
where A.MaBaoTC not in (select distinct B.MaBaoTC
						from DATBAO B)

-- 12 Tên, định kỳ của những tờ báo có nhiều người đặt mua nhất
select A.TenBaoTC, Dinhky, count(MaKH) as SoNguoiDM
from  BAO_TCHI A, DATBAO B
where A.MaBaoTC = B.MaBaoTC
group by A.TenBaoTC, Dinhky, B.MaBaoTC
having count(B.MaKH) >= all (select count(C.MaKH)
							from DATBAO C
							group by C.MaBaoTC)
-- 13 Khách hàng đặt mua nhiều báo, tạp chí nhất
select A.*
from KHACHHANG A, DATBAO B
where A.MaKH = B.MaKH
group by A.MaKH, TenKH, DiaChi
having count(MaBaoTC) >= all (select count(MaBaoTC)
								from DATBAO C
								group by C.MaKH)

-- 14 Các tờ báo phát hành định kì một tháng 2 lần
select *
from BAO_TCHI
where DinhKy = N'Bán nguyệt san'

--select A.*
--from BAO_TCHI A, PHATHANH B
--where A.MaBaoTC = B.MaBaoTC 
--group by A.MaBaoTC, TenBaoTC, DinhKy, SoLuong, GiaBan
--having count(MONTH(NgayPH)) = 2
-- 15 Các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên
select A.*
from BAO_TCHI A, DATBAO B
where A.MaBaoTC = B.MaBaoTC
group by A.MaBaoTC, TenBaoTC, DinhKy, SoLuong, GiaBan
having count(B.MaBaoTC) >= 3

-- Hàm 
-- Tổng tiền mua báo tạp chí của 1 khách hàng cho trước
create function TongTien(@MaKH char(4))
returns int
As
Begin
	declare @sum int
	
	select @sum = sum(SLMua * GiaBan)
	from DATBAO A, BAO_TCHI B
	where A.MaBaoTC = B.MaBaoTC and A.MaKH = @MaKH
	group by A.MaKH
	return @sum
end

drop function TongTien
--goi su dung hàm
select dbo.TongTien('KH01') as N'Tổng tiền mua'
print N'Tổng tiền mua báo tạp chí của khách hàng là: '+ convert(varchar(30),dbo.TongTien('KH01'))

--select TenKH, TenBaoTC, Dinhky, SLMua, (SLMua*GiaBan) as SoTien
--from KHACHHANG A, BAO_TCHI B, DATBAO C
--where A.MaKH = C.MaKH and B.MaBaoTC = C.MaBaoTC 
--group by TenKH, TenBaoTC, Dinhky, SLMua, SLMua*GiaBan

-- Tổng tiền thu được của 1 tờ báo tạp chí cho trước
create function TongTienBaoTChi(@MaBaoTC char(4))
returns int
As
Begin
	declare @sum int
	
	select @sum = sum(SLMua) * GiaBan
	from DATBAO A, BAO_TCHI B
	where A.MaBaoTC = B.MaBaoTC and A.MaBaoTC = @MaBaoTC
	group by A.MaBaoTC, GiaBan
	return @sum
end

drop function TongTienBaoTChi
--goi su dung hàm
select dbo.TongTienBaoTChi('PN02') as N'Tổng tiền mua'
print N'Tổng tiền thu được của tờ báo tạp chí là: '+ convert(varchar(30),dbo.TongTienBaoTChi('PN02'))

--select  A.MaBaoTC, sum(SLMua) * GiaBan as Tien
--from DATBAO A, BAO_TCHI B
--where A.MaBaoTC = B.MaBaoTC 
--group by A.MaBaoTC, GiaBan

-- Thủ tục
-- In danh mục báo, tạp chí phải giao cho 1 hách hàng cho trước
create proc usp_InDanhMucBaoTChi @MaKH char(4)
as
	if exists(select * from KHACHHANG where MaKH = @MaKH)
		begin
			select C.MaKH, TenKH, DiaChi, A.MaBaoTC, TenBaoTC, SLMua, NgayDM, GiaBan
			from DATBAO A, BAO_TCHI B, KHACHHANG C
			where A.MaBaoTC = B.MaBaoTC and A.MaKH = C.MaKH and A.MaKH = @MaKH
		end
	else
		begin
			print N'Không tồn tại mã khách hàng đã nhập'
		end
go

exec usp_InDanhMucBaoTChi 'KH01'