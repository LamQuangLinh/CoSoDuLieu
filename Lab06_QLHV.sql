/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Lâm Quang Linh
   MSSV: 2112998
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: 06/04/2023
*/	
create database Lab06_QLHV
go
use Lab06_QLHV
go

create table CaHoc(
Ca tinyint primary key, GioBatDau time, GioKetThuc time
)

create table GiaoVien(
MSGV nchar(5) primary key, HoGV nvarchar(20), TenGV nvarchar(10),DienThoai int
)

create table Lop (
MaLop nchar(5) primary key, TenLop nchar(20), NgayKG date,HocPhi int, Ca tinyint references CaHoc(Ca),  SoTiet tinyint, SoHV tinyint, MSGV nchar(5) references GiaoVien(MSGV)
)

create table  HocVien(
MSHV nchar(8) primary key, Ho nvarchar(30),Ten nvarchar(10), NgaySinh date, Phai nvarchar(3),MaLop nchar(5) references Lop(MaLop)
)

create table HocPhi (
SoBL nchar(5) primary key, MSHV nchar(8) references HocVien(MSHV),NgayThu date,SoTien int, NoiDung nvarchar(20), NguoiThu nvarchar(5)
)

set dateformat dmy

insert into CaHoc values (1,'07:30','10:45'),
						 (2,'13:30','16:45'),
						 (3,'17:30','20:45')
go
insert into GiaoVien values ('G001','Lê Hoàng','Anh',0858936),
							('G002','Nguyễn Ngọc','Lan',0845623),
							('G003','Trần Minh','Hùng',0823456),
							('G004','Võ Thanh','Trung',0841256)
go
insert into Lop values ('E114','Excel 3-5-7','02/01/2008',120000,1,45,3,'G003'),
					   ('E115','Excel 2-4-6','22/01/2008',120000,3,45,0,'G001'),
					   ('W123','Word 2-4-6','18/02/2008',100000,3,30,1,'G001'),
					   ('W124','Word 3-5-7','01/03/2008',100000,1,30,0,'G002'),
					   ('A075','Access 2-4-6','18/02/2008',150000,3,60,3,'G003')
go
insert into HocVien values ('A07501','Lê Văn','Minh','10/06/1998','Nam','A075'),
						   ('A07502','Nguyễn Thị','Mai','20/04/1998','Nữ','A075'),
						   ('A07503','Lê Ngọc','Tuấn','10/06/1994','Nam','A075'),
						   ('E11401','Vương Tuấn','Vũ','25/03/1999','Nam','E114'),
						   ('E11402','Lý Ngọc','Hân','01/12/1995','Nữ','E114'),
						   ('E11403','Trần Mai','Linh','04/06/1990','Nữ','E114'),
						   ('W12301','Nguyễn Ngọc','Tuyết','12/05/1996','Nữ','W123')
go

insert into HocPhi values ('0001','E11401','02/01/2008',120000,'HP Excel 3-5-7','Vân'),
						  ('0002','E11402','02/01/2008',120000,'HP Excel 3-5-7','Vân'),
						  ('0003','E11403','02/01/2008',80000,'HP Excel 3-5-7','Vân'),
						  ('0004','W12301','18/02/2008',100000,'HP Word 2-4-6','Lan'),
						  ('0005','A07501','16/12/2008',150000,'HP Access 2-4-6','Lan'),
						  ('0006','A07502','16/12/2008',100000,'HP Access 2-4-6','Lan'),
						  ('0007','A07503','18/12/2008',150000,'HP Access 2-4-6','Vân'),
						  ('0008','A07502','15/01/2009',50000,'HP Access 2-4-6','Vân')

select *from CaHoc
select *from GiaoVien
select *from Lop
select *from HocVien
select *from HocPhi

-- Cài đặt ràng buộc toàn vẹn
-- a Giờ bắt đầu ko được trước giờ kết thúc
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc<i.GioBatDau)	
	      begin
	    	 raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)
		     rollback tran
	      end
go	
--b Sĩ số không được >= 30
create trigger trg_Lop_ins_upd
on Lop for insert,update
AS
if Update(MaLop) or Update(SoHV)
Begin
	if exists(select * from inserted i where i.SOHV>30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	if exists (select * from inserted l 
	              where l.SOHV <> (select count(MSHV) 
									from HocVien 
									where HocVien.Malop = l.Malop))
	begin
		raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
	
Go
-- Tổng tiền thu của một học viên không được vượt quá học phí của lớp mà học viên đó đăng ký học
create trigger trg_TongTien_HopPhi
on HocPhi for insert,update
as
if UPDATE(SoTien)
begin
	if exists (select *from inserted i where i.SoTien>(select HocPhi from Lop,HocVien where lop.MaLop=HocVien.MaLop and HocVien.MSHV=i.MSHV) )
	begin
		raiserror (N'Số tiền học phí của một học viên nhiều hơn số tiền của lớp học',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	END
	insert into HocPhi values ('0011','E11401','02/01/2008',180000,'HP Excel 3-5-7','Vân')
-- Viết Hàm
create function SinhMaGV() returns char(4)
As
Begin
	declare @MaxMaGV char(4)
	declare @NewMaGV varchar(4)
	declare @stt	int
	declare @i	int	
	declare @sokyso	int

	if exists(select * from GiaoVien)---Nếu bảng giáo viên có dữ liệu
	 begin
		--Lấy mã giáo viên lớn nhất hiện có
		select @MaxMaGV = max(MSGV) 
		from GiaoVien

		--Trích phần ký số của mã lớn nhất và chuyển thành số 
		set @stt=convert(int, right(@MaxMaGV,3)) + 1 --Số thứ tự của giáo viên mới
	 end
	else--Nếu bảng giáo viên đang rỗng (nghĩa là chưa có giáo viên nào được lưu trữ trong CSDL.
	 set @stt= 1 -- Số thứ tự của giáo viên trong trường hợp chưa có gv nào trong CSDL
	
	--Kiểm tra và bổ sung chữ số 0 để đủ 3 ký số trong mã gv.
	set @sokyso = len(convert(varchar(3), @stt))
	set @NewMaGV='G'
	set @i = 0
	while @i < 3 -@sokyso
		begin
			set @NewMaGV = @NewMaGV + '0'
			set @i = @i + 1
		end	
	set @NewMaGV = @NewMaGV + convert(varchar(3), @stt)

return @NewMaGV	
End
--Thử hàm sinh mã
select * from GiaoVien
print dbo.SinhMaGV()
-- Tổng học phí khi biết mã lớp
create function fn_TongHocPhi1Lop(@malop char(4)) returns int
As
Begin
	declare @TongTien int
	if exists (select * from Lop where MaLop = @MaLop) ---Nếu tồn tại lớp @malop trong CSDL
		Begin
		--Tính tổng số học phí thu được trên 1 lớp
		select @TongTien = sum(SoTien)
		from	HocPhi A, HocVien B	
		where	A.MSHV = B.MSHV and B.Malop = @malop
		End	
	 	
return @TongTien
End
--- thử nghiệm hàm-------
print dbo.fn_TongHocPhi1Lop('A075')

-- Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước. 
create function fn_TongHocPhi(@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongTien int
	--Tính tổng số học phí thu được trong khoảng thời gian từ bắt đầu đến kết thúc
	select @TongTien = sum(SoTien)
	from	HocPhi 	
	where	NgayThu between @bd and @kt
return @TongTien
End
--- thu nghiem ham-------
set dateformat dmy
print dbo.fn_TongHocPhi('1/1/2008','15/1/2008')
-- Tự sinh mã học viên
create function SinhMaHV() returns char(6)
As
Begin
	declare @MaxMSHV char(4)
	declare @NewMSHV varchar(4)
	declare @stt	int
	declare @i	int	
	declare @sokyso	int

	if exists(select * from HocVien)---Nếu bảng giáo viên có dữ liệu
	 begin
		--Lấy mã giáo viên lớn nhất hiện có
		select @MaxMSHV = max(MSHV) 
		from HocVien

		--Trích phần ký số của mã lớn nhất và chuyển thành số 
		set @stt=convert(int, right(@MaxMSHV,3)) + 1 --Số thứ tự của giáo viên mới
	 end
	else--Nếu bảng giáo viên đang rỗng (nghĩa là chưa có giáo viên nào được lưu trữ trong CSDL.
	 set @stt= 1 -- Số thứ tự của giáo viên trong trường hợp chưa có gv nào trong CSDL
	
	--Kiểm tra và bổ sung chữ số 0 để đủ 3 ký số trong mã gv.
	set @sokyso = len(convert(varchar(3), @stt))
	set @NewMSHV=''
	set @i = 0
	while @i < 3 -@sokyso
		begin
			set @NewMaGV = @NewMaGV + '0'
			set @i = @i + 1
		end	
	set @NewMaGV = @NewMaGV + convert(varchar(3), @stt)

return @NewMaGV	
End
--Thử hàm sinh mã
select * from GiaoVien
print dbo.SinhMaGV()
--	TẠO THỦ TỤC--------------------------------------
-- Thêm dữ liệu vào các bảng

CREATE PROC usp_ThemGiaoVien2
@hogv nvarchar(20), @tengv nvarchar(10), @dthoai varchar(10)
As
	declare @Magv char(4)
	
 if not exists(select * from GiaoVien 
				where HoGV = @hogv and TenGV = @tengv and DienThoai = @dthoai)
	Begin
		
		--sinh mã cho giáo viên mới
		set @Magv = dbo.SinhMaGV()
		insert into GiaoVien values(@Magv, @hogv, @tengv,@dthoai)
		print N'Đã thêm giáo viên thành công'
	End
else
	print N'Đã có giáo viên ' + @hogv +' ' + @tengv + ' trong CSDL'
Go

