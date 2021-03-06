USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_COMBOS_IMPRESION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_COMBOS_IMPRESION] ( @Cual Char(4) )
AS
BEGIN
 SET NOCOUNT ON
      IF @cual = 'MERC' SELECT glosa, codigo , nemo   FROM TBAFECTOAPOSICION
 ELSE IF @Cual = 'USUA' SELECT nombre , '' , usuario  FROM VIEW_USUARIO
 ELSE IF @Cual = 'S_OP' SELECT estado, codigo , ''   FROM ESTADO_OPERACION -- Estatus de la operaciÃ³n
 ELSE IF @Cual = 'T_OP' SELECT operacion, codigo , ''  FROM TIPO_DE_OPERACION -- Tipo de la operaciÃ³n
 ELSE IF @Cual = 'MONE' SELECT Mnglosa, mncodmon , MNNEMO  FROM VIEW_MONEDA ORDER BY mncodmon
 ELSE IF @Cual = 'PAGO' SELECT glosa, codigo , ''  FROM VIEW_FORMA_DE_PAGO -- WHERE codigo < 20
 SET NOCOUNT OFF
 
END



GO
