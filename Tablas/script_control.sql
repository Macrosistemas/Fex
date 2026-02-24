IF dbo.f_existe('script_control')='N' BEGIN
   CREATE TABLE dbo.script_control(
    renglon    numeric(8,0) IDENTITY(1,1) NOT NULL,
    cadena     varchar (8000) NULL,
   PRIMARY KEY (renglon))
END ;