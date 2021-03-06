USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_COMBOS_MONITOREO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_COMBOS_MONITOREO]   
	(   @Cual		CHAR(4)   
	,	@Sistema	VARCHAR(4) = ' '  
	)  
AS  
BEGIN  
 SET NOCOUNT ON  

 IF @cual = 'MODU' SELECT nombre_sistema, operativo ,id_sistema   FROM  VIEW_SISTEMA_CNT WHERE operativo ='S' and gestion ='N' and id_sistema <>'MTR'   
-- ELSE IF @Cual = 'USUA' SELECT nombre , '' , usuario  FROM VIEW_USUARIO  where tipo_usuario in('TRADER','SUPERVISOR')  
 ELSE IF @Cual = 'USUA' SELECT nombre , '' , usuario  FROM BacParamSuda.dbo.Usuario  where tipo_usuario like '%TRADER%'
 ELSE IF @Cual = 'S_OP' SELECT estado, codigo , identificador   FROM ESTADO_OPERACIONES -- Estatus de la operación  
 ELSE IF @Cual = 'T_OP' SELECT descripcion, codigo , codigo  FROM bacparamsuda.dbo.OPERACION_PRODUCTO  WHERE (id_sistema = @Sistema or @Sistema = '') -- Tipo de la operación  
 ELSE IF @Cual = 'MONE' SELECT Mnglosa, mncodmon , MNNEMO  FROM VIEW_MONEDA ORDER BY mncodmon  
 ELSE IF @Cual = 'PAGO' SELECT glosa, codigo , ''  FROM VIEW_FORMA_DE_PAGO -- WHERE codigo < 20  
 ELSE IF @Cual = 'DIGI' SELECT CASE WHEN PATINDEX('%-%',usr.nombre) > 0 THEN RTRIM(SUBSTRING(usr.nombre,1,PATINDEX('%-%',usr.nombre)-1)) 
						  ELSE usr.nombre 
						END,
						'',
						usr.usuario
						FROM   BacParamSuda.dbo.USUARIO usr
						LEFT JOIN BacParamSuda.dbo.GEN_TIPOS_USUARIO tip ON tip.Tipo_Usuario = usr.tipo_usuario
						WHERE  tip.Rol          = 'INGRESADOR'
						ORDER BY usr.usuario
  
	SET NOCOUNT OFF
END  
GO
