USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMMANTENEDORSERIES_ELIMINA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMMANTENEDORSERIES_ELIMINA](
       @letra_serie char(15),
       @nemotecnico char(10) )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT 1 FROM LETRA_HIPOTECARIA_SERIE WHERE nemotecnico = @nemotecnico AND letra_serie = @letra_serie) BEGIN
  DELETE FROM LETRA_HIPOTECARIA_SERIE WHERE 
       nemotecnico = @nemotecnico      
                                                    AND letra_serie = @letra_serie
  SELECT 'OK'  
 END
 
 IF EXISTS(SELECT 1 FROM LETRA_HIPOTECARIA_SERIE WHERE  nemotecnico = @nemotecnico AND letra_serie = @letra_serie) BEGIN
 
  DELETE FROM LETRA_HIPOTECARIA_SERIE WHERE 
       nemotecnico = @nemotecnico and
       letra_serie = @letra_serie
  SELECT 'OK'  
 END
 ELSE BEGIN
  
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
 
END

GO
