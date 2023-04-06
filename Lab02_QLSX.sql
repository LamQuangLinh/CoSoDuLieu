/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: 04/04/2023
*/	

---------------------------------------------------
-----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab02_QLSX
go
use Lab02_QLSX
go

create table ToSanXuat
(MaTSX char (5) primary key,
TenTSX Nvarchar (10)
)
go

create table CongNhan
(MACN char(6) primary key,
Ho Nvarchar (20) ,
Ten Nvarchar (10),
Phai Nvarchar (5),
NgaySinh Datetime,
MaTSX char(5) references ToSanXuat(MaTSX)
)
go

create table SanPham
(MASP char(6) primary key,
TenSP Nvarchar (20),
DVT Nvarchar (10),
TienCong int
)
go

create table ThanhPham
(MACN char(6) references CongNhan(MACN),
MASP char (6) references SanPham(MASP),
Ngay datetime,
SoLuong int
)
go

-------------------------------------------------
-------------NHẬP DỮ LIỆU CHO CÁC BẢNG-----------
insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values ('TS02',N'Tổ 2')

insert into SanPham values ('SP001',N'Nồi đất',N'cái',10000)
insert into SanPham values ('SP002',N'Chén',N'cái',2000)
insert into SanPham values ('SP003',N'Bình gốm nhỏ',N'cái',20000)
insert into SanPham values ('SP004',N'Bình gốm lớn',N'cái',25000)

set dateformat dmy 
insert into CongNhan values ('CN001',N'Nguyễn Trường',N'An',N'Nam','12/05/1981',N'TS01')
insert into CongNhan values ('CN002',N'Lê Thị Hồng ',N'Gấm',N'Nữ','04/06/1980',N'TS01')
insert into CongNhan values ('CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981',N'TS02')
insert into CongNhan values ('CN004',N'Võ Hữu',N'Hạnh',N'Nam','15/02/1980',N'TS02')
insert into CongNhan values ('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981',N'TS01')

insert into ThanhPham values ('CN001',N'SP001','01/02/2007',10)
insert into ThanhPham values ('CN002',N'SP001','01/02/2007',5)
insert into ThanhPham values ('CN003',N'SP002','10/01/2007',50)
insert into ThanhPham values ('CN004',N'SP003','12/01/2007',10)
insert into ThanhPham values ('CN005',N'SP002','12/01/2007',100)
insert into ThanhPham values ('CN002',N'SP004','13/02/2007',10)
insert into ThanhPham values ('CN001',N'SP003','14/02/2007',15)
insert into ThanhPham values ('CN003',N'SP001','15/01/2007',20)
insert into ThanhPham values ('CN003',N'SP004','14/02/2007',15)
insert into ThanhPham values ('CN004',N'SP002','30/01/2007',100)
insert into ThanhPham values ('CN005',N'SP003','01/02/2007',50)
insert into ThanhPham values ('CN001',N'SP001','20/02/2007',30)

select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham

-------------------------------------------------
----------------TRUY VẤN DỮ LIỆU-----------------
--1) Liệt kê các công nhân theo tổ sản xuất gồm các thông tin
select TenTSX,Ho+' ' +Ten as HoTen,NgaySinh,Phai
from CongNhan,ToSanXuat
where CongNhan.MaTSX = ToSanXuat.MaTSX
order by TenTSX,Ten

--2) Liệt kê các thành phẩm mà công nhân 'Nguyen Truong An' đã làm được
select TenSP,Ngay, SoLuong,TienCong as ThanhTien
from CongNhan,SanPham,ThanhPham
where CongNhan.MACN= ThanhPham.MACN and SanPham.MASP =ThanhPham.MASP and CongNhan.Ho + ' ' + CongNhan.Ten =N'Nguyễn Trường An'
order by Ngay

--3) Liệt kê các nhân viên không sản xuất sản phẩm 'Bình gốm lớn'
Select	*
From	CongNhan 
Where	MACN NOT IN (	Select	A.MACN
						From	ThanhPham A, SanPham B
						Where	A.MASP = B.MASP and B.TenSP =N'Bình gốm lớn')

--4) Liệt kê thông tin các công nhân có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'
Select	B.MACN, Ho +' '+Ten as HoTen,NgaySinh,Phai
From	 CongNhan B, SanPham C, ThanhPham D
Where	B.MACN = D.MACN and C.MASP = D.MASP 
		and C.TenSP = N'Nồi đất' and B.MACN IN (Select	E.MACN
											From	ThanhPham E, SanPham F
											Where	E.MASP = F.MASP and F.TenSP =N'Bình gốm nhỏ')

--5) Thống kê số lượng công nhân theo từng tổ sản xuất
select TenTSX,COUNT(MACN)as SoLuong
from CongNhan,ToSanXuat
where CongNhan.MaTSX= ToSanXuat.MaTSX
group By TenTSX

--6) Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được 
select Ho,Ten,TenSP,sum(SoLuong) as TongSLSanPham,SoLuong*TienCong as TongThanhTien
From CongNhan,SanPham,ThanhPham
where CongNhan.MACN=ThanhPham.MACN and SanPham.MASP=ThanhPham.MASP
group by Ho,Ten,TenSp,SoLuong,TienCong

--7) Tổng số tiền công đã trả cho công nhân trong tháng tháng 1 năm 2007
select  SUM(SoLuong * TienCong) as TongTienCongDaTra 
from SanPham, ThanhPham
where SanPham.MaSP = ThanhPham.MaSP and Month(Ngay) = 1 and YEAR(Ngay) = 2007

--8) Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007
Select		B.MaSP, TenSP, COUNT(C.MaSP) as SoLanSX 
From		ThanhPham C, SanPham B
Where		C.MaSP = B.MaSP and month(Ngay) = '02' and year(Ngay) = '2007'
Group by	B.MaSP, TenSP
Having		COUNT(C.MaSP)	>=all (select	COUNT(MaSP)
						           From		ThanhPham
						           Group by	MaCN)

--9) Cho biết công nhân sản xuất được nhiều 'Chén' nhất
select Ho+' '+ten,SoLuong,TenSP
from CongNhan,ThanhPham,SanPham

Where	SanPham.MASP = ThanhPham.MASP and CongNhan.MACN=ThanhPham.MACN and
		ThanhPham.SoLuong = (Select Max(E.SoLuong)
											From	ThanhPham E, SanPham F
											Where	SanPham.MASP = ThanhPham.MASP and TenSP=N'Chén')

--10) tiền công tháng 2/2007 của công nhân viên có mã số 'CN002'
select sum(SanPham.TienCong * ThanhPham.SoLuong) as TienCongThang2
from ThanhPham, SanPham 
Where ThanhPham.MASP = SanPham.MaSP  and MaCN='CN002' and Month(Ngay) = 2 and Year(Ngay) = 2007

--11) Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
Select	 A.MaCN, Ho+' '+Ten as HoTen, COUNT(MaSP) as SoLanSX
From	CongNhan A, ThanhPham B
Where	A.MaCN = B.MaCN
Group by	A.MaCN, Ho+' '+Ten
Having	COUNT(MaSP) >= 3

--12) Cập nhập giá tiền công của các loại bình gốm thêm 1000
UPDATE SanPham
SET TienCong = 21000
WHERE MASP = 'SP003' ;
UPDATE SanPham
SET TienCong = 26000
WHERE MASP = 'SP004' ;
select * from SanPham

--13) Thêm bộ <'CN006','Lê Thị','Lan','Nữ','TS02'> vào bảng CongNhan
insert into CongNhan(MACN,Ho,Ten,Phai,NgaySinh,MaTSX) values ( 'CN006',N'Lê Thị',N'Lan',N'Nữ',Null,N'TS02')

-------------------------------------------------
----------------THỦ TỤC & HÀM--------------------
--Aa) Tính tổng số công nhân của một tổ sản xuất cho trước
create function fn_TongCongNhan1To(@Matsx char(5)) returns int
As
Begin
	declare @TongCongNhan int
	if exists (select * from ToSanXuat where MaTSX = @Matsx) 
		Begin

		select @TongCongNhan = count(MACN)
		from	ToSanXuat A, CongNhan B	
		where	A.MaTSX = B.MaTSX and B.MaTSX = @Matsx
		End	
	 	
return  @TongCongNhan
End
------Thử nghiệm hàm-------
print dbo.fn_TongCongNhan1To('TS01')
print dbo.fn_TongCongNhan1To('TS02')

--Ab) Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước
create function fn_TongThanhPham1Thang(@MaSP char(6),@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongThanhPham int
	if exists (select * from ThanhPham where MASP = @MaSP) 
		Begin
		
		select @TongThanhPham = sum(SoLuong)
		from	SanPham A, ThanhPham B	
		where	A.MASP = B.MASP	 and B.MASP = @MaSP and Ngay between @bd and @kt
		End	
	 	
return   @TongThanhPham 
End
------Thử nghiệm hàm------- 
set dateformat dmy
print dbo.fn_TongThanhPham1Thang('SP001','1/2/2007','28/2/2007')

--Ac) Tính tổng tiền công tháng của một công nhân cho trước
create function fn_TongTienCong1Thang(@maCN char(6),@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongTienCong int
	if exists (select * from ThanhPham where MACN = @maCN) 
		Begin
		
		select @TongTienCong = sum(SoLuong* TienCong)
		from	CongNhan A, ThanhPham B	,SanPham C
		where	A.MACN = B.MACN	 and B.MASP = C.MASP and B.MACN = @maCN and Ngay between @bd and @kt
		End	
	 	
return  @TongTienCong
End
------Thử nghiệm hàm------- 
set dateformat dmy
print dbo.fn_TongTienCong1Thang('CN001','1/2/2007','28/2/2007')

--Ad) Tính tổng thu thập trong năm của một tổ sản xuất cho trươsc
create function fn_TongThuNhap1Nam(@maTSX char(5),@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongThuNhap int
	if exists (select * from ToSanXuat where MaTSX = @maTSX) 
		Begin
		
		select @TongThuNhap = sum(SoLuong* TienCong)
		from	ToSanXuat A , ThanhPham B	,SanPham C , CongNhan D
		where A.MaTSX = D.MaTSX and b.MASP = C.MASP and  D.MACN = B.MACN and A.MaTSX = @maTSX and Ngay between   @bd and @kt
		End	
	 	
return  @TongThuNhap
End
-----Thử nghiệm hàm-------
set dateformat dmy
print dbo.fn_TongThuNhap1Nam('TS01','1/1/2007','30/12/2007')

--Ae) Tính tổng sản lượng sản xuất của một loại sản phẩm trong một khoảng thời gian cho trước
create function fn_TongSanLuongTrong1ThoiGian(@MaSP char(6) ,@bd datetime, @kt datetime) returns int
as
begin
	declare @TongSanLuong int
		if exists (select * from SanPham where MASP = @MaSP) 
	begin
		select @TongSanLuong = sum(SoLuong) 
		from ThanhPham B
		where B.MASP =@MaSP and Ngay between @bd and @kt
	end
	return @TongSanLuong
end
------Thử nghiệm hàm-------
print dbo.fn_TongSanLuongTrong1ThoiGian('SP001','01/02/2007','14/02/2007')

--Ba) In danh sách các công nhân của một tổ sản xuất cho trước
create proc usp_InDanhSachCongNhan @MaTSX char(5) 
as
begin
	if exists(select * from CongNhan where MaTSX = @MaTSX)
		begin 
			select * 
			from CongNhan A
			where A.MaTSX = @MaTSX
		end
	else 
		print N'Tổ sản xuất không tồn tại'
end
------Thử nghiệm hàm-------
exec usp_InDanhSachCongNhan 'TS01'
exec usp_InDanhSachCongNhan 'TS02'

--Bb) In bảng chấm công sản xuất trong tháng của một công nhân cho trước
create proc usp_InBangChamCong @MaCN char(5)
as
begin
	if exists(select * from CongNhan where MaCN = @MaCN)
		begin 
			select TenSP, DVT, SoLuong, TienCong, (SoLuong * TienCong) as ThanhTien
			from SanPham A, ThanhPham B
			where A.MaSP = B.MaSP and MaCN = @MaCN
		end
	else 
		print N'Công nhân không tồn tại'
end
------thử nghiệm hàm-------
exec usp_InBangChamCong 'CN001' 