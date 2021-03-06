USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_FOLIOS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRAE_FOLIOS]
                                 ( @xFormaPago NUMERIC(02)  ,
     @xCorr_Inte NUMERIC(02)  )
AS
BEGIN
 IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xFormaPago AND
          correla_interno= @xCorr_Inte AND
          estado   = 'N') BEGIN
             SELECT 'NO','CORRELATIVO DE FOLIO YA SE ENCUENTRA DEFASADO',Folio_Inicio,Folio_Actual,Folio_Termino
      FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xFormaPago AND
          correla_interno= @xCorr_Inte AND
          estado   = 'N'
      RETURN 
 END
 IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xFormaPago AND
          correla_interno= @xCorr_Inte AND
          estado   = 'A') BEGIN
             SELECT 'NO','Correlativo de folio se esta usando actualmente',Folio_Inicio,Folio_Actual,Folio_Termino
      FROM BAC_TESORERIA_FOLIOS
      WHERE  tipo_documento = @xFormaPago AND
       correla_interno= @xCorr_Inte AND
       estado   = 'A'
      RETURN 
 END
 IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xFormaPago AND
          correla_interno= @xCorr_Inte AND
          estado   = '') BEGIN
             SELECT 'SI',Folio_Inicio,Folio_Actual,Folio_Termino FROM BAC_TESORERIA_FOLIOS
           WHERE tipo_documento = @xFormaPago AND
          correla_interno= @xCorr_Inte AND
          estado   = ''
      RETURN 
 END
SELECT 'OK'
END     
--Sp_Trae_Folios 3,    1


GO
