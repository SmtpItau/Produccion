USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DOCPAGOMONEDA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_DOCPAGOMONEDA]( @CodMon   INTEGER =  0 ,
                                        @MonPago  INTEGER =  0 ,
                                        @FPago    INTEGER =  0 ,
                                        @Activo   CHAR(1) = '1')
AS
BEGIN
set nocount on
     SELECT mfcodmon            ,  -- 1
            ISNULL(a.mnglosa,''),  -- 2
            mfmonpag            ,  -- 3
            ISNULL(b.mnglosa,''),  -- 4
            mfcodfor            ,  -- 5
            ISNULL(glosa,'')    ,  -- 6
            mfestado            ,  -- 7
     diasvalor             -- 8  
       FROM view_moneda_forma_de_pago,
            view_moneda a,
            view_moneda b,
            view_forma_de_pago
      WHERE (mfcodmon = @CodMon  OR @CodMon  =  0)
        AND (mfmonpag = @MonPago OR @MonPago =  0)
        AND (mfcodfor = @FPago   OR @FPago   =  0)
        AND (mfestado = @Activo  OR @Activo  = '')
        AND  mfcodmon = a.mncodmon
        AND  mfmonpag = b.mncodmon
        AND  mfcodfor = codigo
      ORDER BY mfcodmon, mfmonpag, mfcodfor
END
--
--select * from view_moneda_forma_de_pago



GO
