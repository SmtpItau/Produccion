USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_Digito_VERIFICADOR]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_Digito_VERIFICADOR](@irut_i NUMERIC(10))
AS
BEGIN

   SET DATEFORMAT DMY
   SET NOCOUNT ON
   
   DECLARE @i      AS Integer
   DECLARE @D      AS Integer
   DECLARE @Divi   AS FLOAT
   DECLARE @suma   AS FLOAT
   DECLARE @Digito AS CHAR(3)
   DECLARE @multi  AS FLOAT
   DECLARE @irut   AS CHAR(8) 
   
   SELECT @irut = @irut_i 
   SELECT @irut = @irut + REPLICATE("0",8-LEN(@irut)) 


   SELECT @multi = 0 
   SELECT @suma  = 0
   SELECT @divi = 0 
   SELECT @digito = ''



   SET @D = 2

   SELECT @i = 8 

   WHILE @i > 0 
   BEGIN


    SELECT  @multi = CONVERT(NUMERIC(10),(SUBSTRING(@irut, @i, 1)) * @D)

    SELECT  @suma = @suma + @multi
    SELECT  @D = @D + 1


      If @D = 8 BEGIN
        SET @D = 2
      END 


    SELECT @I = @I - 1
   END  


   SELECT @Divi = CONVERT(INT ,@suma / 11)


   SELECT @multi = @Divi * 11
   SELECT @Digito = (11 - (@suma - @multi))
    
   If @Digito = "10" BEGIN
    SET  @Digito = "K"
   
   End 
    
   If @Digito = "11" BEGIN
     SET @Digito = "0"
   End 
    
   SELECT UPPER(@Digito)

END

--SP_CON_Digito_VERIFICADOR 97011000





GO
