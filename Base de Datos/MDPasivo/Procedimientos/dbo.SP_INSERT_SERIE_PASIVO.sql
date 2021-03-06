USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_SERIE_PASIVO]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_SERIE_PASIVO]
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

DELETE SERIE_PASIVO
 
INSERT INTO SERIE_PASIVO 
			( codigo_instrumento,
			  nombre_serie,
			  rut_emisor,
			  tasa_emision,
			  codigo_base,
			  um_serie,
			  tasa_tera,
			  periodo_amortizacion,
			  numero_amortizacion,
			  plazo,
			  codigo_periodo,
			  cupones,
			  fecha_vencimiento,
			  fecha_emision,
			  bono_subordinado,
			  tasa_variable,
			  numero_decimales,
			  fecha_primer_corte
			)

			SELECT 
			   SECODIGO,
			   SEINSTSER,
			   SERUTEMIS,
			   SETASEMIS,
			   SEBASTASA,
			   SEUNITRAN,
			   SETERA,
			   CASE WHEN SEPERVCUP = 6  THEN  3 
				WHEN SEPERVCUP = 3  THEN  2
				WHEN SEPERVCUP = 12 THEN  4 
			   END,
			   SENUMAMOR,
			   SEPLAZO,
			   SEDIAVCUP,
			   SECUPONES,
			   SEFECVENC,
			   SEFECEMI,
			   ISNULL(SESUBORDI,'N'),
			   'N',
			   4,
			   SEFECPEMI
	
 			FROM 	DESARROLLO.MDSE 
			  
END

GO
