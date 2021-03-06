USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeeUltimaUF]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[Sp_LeeUltimaUF] 
                (@fechauf  datetime ,
                 @fechaipc datetime ) 
AS
BEGIN




   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    declare @nvaloruf  float 
    declare @cfechauf  char(10)
    declare @nvaloripc float
    declare @cfechaipc char(10)
    SET ROWCOUNT 1  
    SELECT @nvaloruf = vmvalor, @cfechauf   = CONVERT(CHAR(10),vmfecha,101) 
                                              FROM   VALOR_MONEDA  
                                              WHERE  vmcodigo = 998  AND @fechaUf = vmfecha
    SELECT @nvaloripc = vmvalor,@cfechaipc =  CONVERT(CHAR(10),vmfecha,101)
                                              FROM   VALOR_MONEDA 
                                              WHERE  vmcodigo = 500  AND @fechaIpc = vmfecha
                                              ORDER  BY vmfecha DESC
 
       
    SELECT @nvaloruf = ISNULL(@nvaloruf,vmvalor), @cfechauf = isnull(@cfechauf,CONVERT(CHAR(10),@fechaUf,101)) 
                                              FROM VALOR_MONEDA 
                                              WHERE  vmcodigo = 998                                              
                                              ORDER BY vmfecha DESC

    
    SELECT @nvaloripc = isnull(@nvaloripc,vmvalor) , @cfechaipc = isnull(@cfechaipc,CONVERT(CHAR(10),vmfecha,101)) 
                                              FROM  VALOR_MONEDA 
                                              WHERE vmcodigo = 500                                              
                                              ORDER BY vmfecha DESC
  


    IF RTRIM(@cfechauf)  <> '' SELECT @cfechauf  = SUBSTRING(@cfechauf,4,2)  + '/' + SUBSTRING(@cfechauf,1,2)  + '/' +  SUBSTRING(@cfechauf,7,4)
    IF RTRIM(@cfechaipc) <> '' SELECT @cfechaipc = SUBSTRING(@cfechaipc,4,2) + '/' + SUBSTRING(@cfechaipc,1,2) + '/' +  SUBSTRING(@cfechaipc,7,4)
    SELECT 'ValorUf'  = ISNULL(@nvaloruf , 0.00), 
           'FechaUF'  = ISNULL(@cfechauf ,   ''), 
           'ValorIPC' = ISNULL(@nvaloripc, 0.00), 
           'FechaIPC' = ISNULL(@cfechaipc,   '')
    SET ROWCOUNT 0
 
    RETURN
END



GO
