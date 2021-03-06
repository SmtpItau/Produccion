USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANALISIS_VOUCHER_LLENA_GRILLAVOUCHER]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ANALISIS_VOUCHER_LLENA_GRILLAVOUCHER](
        @Fecha_Desde DateTime,
        @Fecha_Hasta DateTime,
        @Id_Sistema Char(3),
        @Cod_PRODUCTO Char(5),
        @Num_Voucher Numeric(8)  
       )
AS
BEGIN
 SET NOCOUNT ON
 
 IF @Fecha_Desde <> '' AND @Fecha_Hasta <> '' AND @Id_Sistema <> '' AND @Cod_PRODUCTO <> '' AND @Num_Voucher <> 0 BEGIN
 
  IF EXISTS(SELECT numero_voucher,glosa,tipo_voucher,fecha_ingreso FROM BAC_CNT_VOUCHER WHERE fecha_ingreso  >=  @Fecha_Desde And fecha_ingreso  >=  @Fecha_Hasta And ID_SISTEMA  =  @Id_Sistema And CODIGO_PRODUCTO =  @Cod_PRODUCTO And numero_voucher =  @Num_Voucher  ) BEGIN
  
   SELECT  numero_voucher,
    glosa,
    tipo_voucher,
    fecha_ingreso
   FROM BAC_CNT_VOUCHER
   WHERE fecha_ingreso  >=  @Fecha_Desde And
    fecha_ingreso  >=  @Fecha_Hasta And
    id_sistema  =  @Id_Sistema And
    codigo_PRODUCTO =  @Cod_PRODUCTO And
    numero_voucher =  @Num_Voucher  
   ORDER BY numero_voucher   
  END
 END
 IF @Fecha_Desde <> '' AND @Fecha_Hasta <> '' AND @Id_Sistema <> '' AND @Cod_PRODUCTO = '' AND @Num_Voucher <> 0 BEGIN
  IF EXISTS(SELECT numero_voucher,glosa,tipo_voucher,fecha_ingreso FROM BAC_CNT_VOUCHER WHERE fecha_ingreso  >=  @Fecha_Desde And fecha_ingreso  >=  @Fecha_Hasta And id_sistema  =  @Id_Sistema And numero_voucher =  @Num_Voucher  ) BEGIN
  
   SELECT  numero_voucher,
    glosa,
    tipo_voucher,
    fecha_ingreso
   FROM BAC_CNT_VOUCHER
   WHERE fecha_ingreso  >=  @Fecha_Desde And
    fecha_ingreso  >=  @Fecha_Hasta And
    id_sistema  =  @Id_Sistema And
    numero_voucher =  @Num_Voucher  
   ORDER BY numero_voucher   
  END
 END
 IF @Fecha_Desde <> '' AND @Fecha_Hasta <> '' AND @Id_Sistema <> '' AND @Cod_PRODUCTO <> '' AND @Num_Voucher = 0 BEGIN 
  IF EXISTS(SELECT numero_voucher,glosa,tipo_voucher,fecha_ingreso FROM BAC_CNT_VOUCHER WHERE fecha_ingreso  >=  @Fecha_Desde And fecha_ingreso  >=  @Fecha_Hasta And id_sistema  =  @Id_Sistema And codigo_PRODUCTO =  @Cod_PRODUCTO ) BEGIN
  
   SELECT  numero_voucher,
    glosa,
    tipo_voucher,
    fecha_ingreso
   FROM BAC_CNT_VOUCHER
   WHERE fecha_ingreso  >=  @Fecha_Desde And
    fecha_ingreso  >=  @Fecha_Hasta And
    id_sistema  =  @Id_Sistema And
    codigo_PRODUCTO =  @Cod_PRODUCTO 
   ORDER BY numero_voucher   
  END
 END
 IF @Fecha_Desde <> '' AND @Fecha_Hasta <> '' AND @Id_Sistema <> '' AND @Cod_PRODUCTO = '' AND @Num_Voucher = 0 BEGIN 
  IF EXISTS(SELECT numero_voucher,glosa,tipo_voucher,fecha_ingreso FROM BAC_CNT_VOUCHER WHERE fecha_ingreso  >=  @Fecha_Desde And fecha_ingreso  >=  @Fecha_Hasta And id_sistema  =  @Id_Sistema ) BEGIN
  
   SELECT  numero_voucher,
    glosa,
    tipo_voucher,
    fecha_ingreso
   FROM BAC_CNT_VOUCHER
   WHERE fecha_ingreso  >=  @Fecha_Desde And
    fecha_ingreso  >=  @Fecha_Hasta And
    id_sistema  =  @Id_Sistema 
   ORDER BY numero_voucher   
  END
 END
 IF @Fecha_Desde <> '' AND @Fecha_Hasta <> '' AND @Id_Sistema = '' AND @Cod_PRODUCTO = '' AND @Num_Voucher = 0 BEGIN
 
  IF EXISTS(SELECT numero_voucher,glosa,tipo_voucher,fecha_ingreso FROM BAC_CNT_VOUCHER WHERE fecha_ingreso  >=  @Fecha_Desde And fecha_ingreso  >=  @Fecha_Hasta) BEGIN
  
   SELECT  numero_voucher,
    glosa,
    tipo_voucher,
    fecha_ingreso
   FROM BAC_CNT_VOUCHER
   WHERE fecha_ingreso  >=  @Fecha_Desde And
    fecha_ingreso  >=  @Fecha_Hasta 
   ORDER BY numero_voucher   
  END
 END
 IF @Fecha_Desde <> '' AND @Fecha_Hasta <> '' AND @Num_Voucher <> 0 BEGIN
  IF EXISTS(SELECT numero_voucher,glosa,tipo_voucher,fecha_ingreso FROM BAC_CNT_VOUCHER WHERE fecha_ingreso  >=  @Fecha_Desde And fecha_ingreso  >=  @Fecha_Hasta And numero_voucher =  @Num_Voucher  ) BEGIN
  
   SELECT  numero_voucher,
    glosa,
    tipo_voucher,
    fecha_ingreso
   FROM BAC_CNT_VOUCHER
   WHERE fecha_ingreso  >=  @Fecha_Desde And
    fecha_ingreso  >=  @Fecha_Hasta And
    numero_voucher =  @Num_Voucher  
   ORDER BY numero_voucher   
  END
 END
 SET NOCOUNT OFF
END

GO
