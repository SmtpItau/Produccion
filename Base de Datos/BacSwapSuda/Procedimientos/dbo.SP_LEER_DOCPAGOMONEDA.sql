USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DOCPAGOMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_DOCPAGOMONEDA]( 
                                        @CodMon   INTEGER =  0 ,
                                        @MonPago  INTEGER =  0 ,
                                        @FPago    INTEGER =  0 ,
                                        @Activo   CHAR(1) = '1',
                                        @sistema  char(3)     )
AS
BEGIN
     SELECT mfcodmon            ,  -- 1
            ISNULL(a.mnglosa,''),  -- 2
            mfmonpag            ,  -- 3
            ISNULL(b.mnglosa,''),  -- 4
            mfcodfor            ,  -- 5
            ISNULL(glosa,'')    ,  -- 6
            mfestado               -- 7

       FROM VIEW_MONEDA_FORMA_DE_PAGO,    --mdmf  ,
            VIEW_MONEDA a,                --mdmn a,
            VIEW_MONEDA b,                --mdmn b,
            VIEW_FORMA_DE_PAGO            --mdfp

      WHERE (mfcodmon = @CodMon  OR @CodMon  =  0)
        AND (mfmonpag = @MonPago OR @MonPago =  0)
        AND (mfcodfor = @FPago   OR @FPago   =  0)
        AND (mfestado = @Activo  OR @Activo  = '')
        AND  mfcodmon = a.mncodmon
        AND  mfmonpag = b.mncodmon
        AND  mfcodfor = codigo
        And  mfsistema = @sistema 
      ORDER BY mfcodmon, mfmonpag, mfcodfor

END

GO
