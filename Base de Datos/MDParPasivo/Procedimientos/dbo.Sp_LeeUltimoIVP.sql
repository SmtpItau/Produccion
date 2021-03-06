USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeeUltimoIVP]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[Sp_LeeUltimoIVP]
                (@fechaivp datetime ,
                 @fechaipc datetime ) 

AS
BEGIN

    SET NOCOUNT ON  
    SET DATEFORMAT dmy

    declare @nvalorivp  float 
    declare @cfechaivp  char(10)
    declare @nvaloriipc float
    declare @cfechaiipc char(10)
    SET ROWCOUNT 1  
    SELECT @nvalorivp = vmvalor, @cfechaivp   = CONVERT(CHAR(10),vmfecha,101) 
                                                FROM   VALOR_MONEDA 
                                                WHERE  vmcodigo = 997 AND vmfecha = @fechaivp

    SELECT @nvaloriipc = vmvalor, @cfechaiipc = convert(char(10),vmfecha, 101)
                                                FROM VALOR_MONEDA
                                                WHERE vmcodigo = 502 AND vmfecha = @fechaipc
                                    

    SELECT @nvalorivp = isnull(@nvalorivp,vmvalor), @cfechaivp   = isnull(@cfechaivp,CONVERT(CHAR(10),@fechaivp,101))
                                                    FROM     VALOR_MONEDA 
                                                    WHERE    vmcodigo = 997 
                                                    ORDER BY vmfecha DESC
    SELECT @nvaloriipc= isnull(@nvaloriipc,vmvalor),@cfechaiipc = isnull(@cfechaiipc,CONVERT(CHAR(10),vmfecha,101)) 
                                                    FROM     VALOR_MONEDA
                                                    WHERE    vmcodigo = 502
                                                    ORDER BY vmfecha DESC 
                                   
 
    if rtrim(@cfechaivp)  <> '' select @cfechaivp  = substring(@cfechaivp,4,2)  + '/' + substring(@cfechaivp,1,2)  + '/' +  substring(@cfechaivp,7,4)
    if rtrim(@cfechaiipc) <> '' select @cfechaiipc = substring(@cfechaiipc,4,2) + '/' + substring(@cfechaiipc,1,2) + '/' +  substring(@cfechaiipc,7,4)
    SELECT 'ValorIVP'  = ISNULL(@nvalorivp , 0.00), 
           'FechaIVP'  = ISNULL(@cfechaivp ,  @cfechaiipc), 
           'ValorIPC'  = ISNULL(@nvaloriipc, 0.00), 
           'FechaIIPC' = ISNULL(@cfechaiipc,   '')
    SET ROWCOUNT 0
    RETURN

    SET NOCOUNT OFF
  
END






GO
