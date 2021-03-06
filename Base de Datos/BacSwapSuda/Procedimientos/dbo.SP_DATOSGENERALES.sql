USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSGENERALES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DATOSGENERALES]
AS
BEGIN

   SET NOCOUNT ON 

   DECLARE  @Cantidad INTEGER
   SET      @Cantidad    = 1 --> (SELECT COUNT(1) FROM BacSwapSuda.dbo.CARTERA)

      SELECT	entidad
		, codigo
		, nombre          = clnombre
      		, rut             = clrut
      		, direccion       = isnull( cldirecc, '')
		, comuna          = isnull( nom_ciu, '')
		, ciudad          = isnull( ciudad, '')
		, telefono        = isnull( clfono, 0)
		, fax             = isnull( clfax, 0)
		, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
		, fechaproc       = CONVERT(CHAR(10), fechaProc, 103)
		, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
		, numero_operacion
		, rutbcch
		, iniciodia
		, libor
		, paridad
		, tasamtm
		, tasas
		, findia
		, cierreMesa
		, codigo_cliente = codigobanco
		, devengo
		, contabilidad		
		, 'Cantidad'     = @Cantidad
		, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
		, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
		, 'digrut'            = cldv
		, 'RutComder'	      = (SELECT acRutComder FROM bacfwdsuda.dbo.MFAC WITH (NOLOCK))													--Prd_19111 Comder
		, 'ActivaComder'      = (SELECT acswActivaComder FROM bacfwdsuda.dbo.MFAC WITH (NOLOCK))											--Prd_19111 Comder

	FROM	SwapGeneral
          INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco
          LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com
END

GO
