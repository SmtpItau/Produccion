USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_COMBOS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_COMBOS] 
( @Cual    CHAR(4) 
, @Sistema VARCHAR(4) = ' '
)
AS
BEGIN
 SET NOCOUNT ON
 IF @cual = 'MODU' SELECT nombre_sistema, operativo ,id_sistema   FROM 	VIEW_SISTEMA_CNT WHERE operativo ='S' and gestion ='N' and id_sistema <>'MTR' 
 ELSE IF @Cual = 'USUA' SELECT nombre , '' , usuario  FROM VIEW_USUARIO
 ELSE IF @Cual = 'S_OP' SELECT estado, codigo , identificador   FROM ESTADO_OPERACIONES -- Estatus de la operación
 ELSE IF @Cual = 'T_OP' SELECT descripcion, codigo , codigo  FROM bacparamsuda..OPERACION_PRODUCTO  WHERE (id_sistema = @Sistema or @Sistema = '') -- Tipo de la operación
 ELSE IF @Cual = 'MONE' SELECT Mnglosa, mncodmon , MNNEMO  FROM VIEW_MONEDA ORDER BY mncodmon
 ELSE IF @Cual = 'PAGO' SELECT glosa, codigo , ''  FROM VIEW_FORMA_DE_PAGO -- WHERE codigo < 20
 SET NOCOUNT OFF

END
GO
