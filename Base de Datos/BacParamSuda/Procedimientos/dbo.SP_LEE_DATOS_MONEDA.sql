USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DATOS_MONEDA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_DATOS_MONEDA]
                (
                  @ncodmon     NUMERIC(5,0)  ,   -- RUT Cliente
                  @ncodmon2    NUMERIC(5,0)      -- Codigo Cliente 
                )
AS
BEGIN
   SET NOCOUNT ON
    --Select "Tip moneda uno " = a.mnnemo, 
    --"Tip moneda glosa " = a.mnglosa
    --"Tip moneda dos " = b.mnnemo, 
    --"Tip moneda glosa2 " = b.mnglosa 
SELECT * FROM MONEDA
where mncodmon = @ncodmon 
        --from  moneda a --, moneda b 
       --where a.mncodmon = @ncodmon --and b.mncodmon = @ncodmon2
   
   SET NOCOUNT OFF
END
--O
--SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
--GO
-- sp_lee_datos_moneda 13,999
-- select * from moneda
---  - select * from mfca
-- delete from 
--sp_lee_datos_moneda 13,999
--sp_help moneda

GO
