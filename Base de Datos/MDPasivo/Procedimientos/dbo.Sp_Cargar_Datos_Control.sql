USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cargar_Datos_Control]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Cargar_Datos_Control]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

      SELECT 'Nombre'		= Nombre_Entidad
         ,   'Codigo'		= Codigo_Entidad
         ,   'Rut'		= Rut_Entidad
         ,   'Direccion'	= Direccion_Entidad
         ,   'Comuna'		= Comuna_Entidad
         ,   'Ciudad'		= Ciudad_Entidad
         ,   'Fono'		= Fono_Entidad
	 ,   'tiempoOtc'	= Tiempo_Otc
         ,   'NumeroOperCAM'	= Numero_operacion_SPT
	 ,   'NumeroOperFWD'	= Numero_Operacion_FWD
         ,   'NumeroOperBTR'	= Numero_operacion_Btr
         ,   '13_BTR'		= Max_Papeletas
	 ,   'NumeroOperSWP'	= Numero_operacion_SWP
	 ,   'NumeroOperINV'	= Numero_Operacion_INV
	 ,   'NumeroOperPAS'	= Numero_Operacion_PAS
	 ,   'Fax'	    	= Fax_Entidad
         ,   'ValidaLinea'      = Valida_Linea
	 ,   'Puerto_UDP'	= puerto_UDP
	FROM DATOS_GENERALES


SET NOCOUNT OFF

END


GO
