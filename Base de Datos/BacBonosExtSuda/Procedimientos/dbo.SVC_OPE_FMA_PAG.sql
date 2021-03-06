USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_OPE_FMA_PAG]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[SVC_OPE_FMA_PAG]
(
      @CodMon   INTEGER =  0 ,
      @MonPago  INTEGER =  0 ,
      @FPago    INTEGER =  0 ,
      @Activo   CHAR(1) = '1'
)
AS
BEGIN
set nocount on
     SELECT mfcodmon            ,  -- 1
            ISNULL(a.mnglosa,''),  -- 2
            mfmonpag            ,  -- 3
            ISNULL(b.mnglosa,''),  -- 4
            mfcodfor            ,  -- 5
            ISNULL(glosa,'')    ,  -- 6
            mfestado               -- 7
       FROM VIEW_MONEDA_FORMA_DE_PAGO  ,
            VIEW_MONEDA a,
            VIEW_MONEDA b,
            VIEW_FORMA_DE_PAGO
      WHERE (mfcodmon = @CodMon  OR @CodMon  =  0)
        AND (mfmonpag = @MonPago OR @MonPago =  0)
        AND (mfcodfor = @FPago   OR @FPago   =  0)
        AND (mfestado = @Activo  OR @Activo  = '')
        AND  mfcodmon = a.mncodmon
        AND  mfmonpag = b.mncodmon
        AND  mfcodfor = codigo
      ORDER BY mfcodmon, mfmonpag, mfcodfor
END

GO
