USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DATOS_MONEDA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_DATOS_MONEDA]
                (
                    @ncodmon     NUMERIC(5,0)  ,   -- RUT Cliente
                    @ncodmon2    NUMERIC(5,0)      -- Codigo Cliente 
                )
AS
BEGIN
   SET NOCOUNT ON
    select	'Tip moneda uno ' = a.mnnemo, 
			'Tip moneda glosa ' = a.mnglosa,
			'Tip moneda dos ' = b.mnnemo, 
			'Tip moneda glosados ' = b.mnglosa
 
        from  VIEW_MONEDA A, VIEW_MONEDA B
       where A.mncodmon =  @ncodmon AND B.mncodmon =  @ncodmon2
   
   SET NOCOUNT OFF
END

GO
