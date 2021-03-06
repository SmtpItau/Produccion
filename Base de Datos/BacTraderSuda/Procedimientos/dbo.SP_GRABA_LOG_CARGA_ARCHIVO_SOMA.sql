USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_LOG_CARGA_ARCHIVO_SOMA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_GRABA_LOG_CARGA_ARCHIVO_SOMA](     
     @FechaProceso  CHAR(8)  ,
     @Terminal CHAR(15)      ,
     @Usuario  CHAR(15)      ,
     @Id_Sistema  CHAR(3)    ,
     @TipOper   CHAR(3)       ,
     @FolioSOMA   NUMERIC (09,0),
     @CorrelaSOMA NUMERIC (03,0),
     @Serie       VARCHAR(20),
     @NominalSOMA FLOAT,
     @NominalBAC FLOAT,
     @NonbreArchivo VARCHAR(50),
     @Observ  VARCHAR(250) 
     )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Hora VARCHAR (15)
 SELECT  @Hora = CONVERT(CHAR(15),GETDATE(),114)

 INSERT INTO Log_Carga_Archivo_SOMA
  (	FechaProceso	 ,
	HoraProceso       ,
	Terminal          ,
	Usuario           ,
	Id_Sistema        ,
	Tipo_Operacion    ,
	FolioSOMA         ,
	CorrelaSOMA       ,
	Serie             ,
	Nominal_SOMA      ,
	Nominal_BAC       ,
	Nombre_Archivo    , 
	Observacion_Carga 
    )
 VALUES ( 
  ISNULL (@FechaProceso,' ')  ,
  ISNULL (@Hora,' ') ,
  ISNULL (@Terminal,' ')   ,
  ISNULL (@Usuario,' ')    ,
  ISNULL (@id_Sistema,' ') ,
  ISNULL (@TipOper,' ')    ,
  ISNULL (@FolioSOMA,0)  ,
  ISNULL (@CorrelaSOMA,0),
  ISNULL (@Serie,' ')    ,
  ISNULL (@NominalSOMA,0),
  ISNULL (@NominalBAC,0) ,
  ISNULL (@NonbreArchivo,' ') ,
  ISNULL (@Observ,' ')  
  )
 SELECT 'OK'
 SET NOCOUNT OFF 
END


GO
