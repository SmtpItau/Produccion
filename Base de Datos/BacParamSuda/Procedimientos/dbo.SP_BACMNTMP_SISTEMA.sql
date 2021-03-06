USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMNTMP_SISTEMA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMNTMP_SISTEMA]
AS
BEGIN
/*
NOMBRE              : dbo.SP_BACMNTMP_SISTEMA.sql
AUTOR               : 
DESCRIPCION			: Carga sistema que no son NY.
FECHA CREACIÓN		: 2017.06.05

HISTÓRICO DE CAMBIOS
FECHA		AUTOR		TAG
----------------------------------------------------------------------------------------------------------------------------------------
2017.06.05	CVS			cvegasan 2017.06.05	Quedan Fuera los sistema que son NY
2018.04.26	CVS			cvegasan 2018.04.26 Se deja fuera en procedimiento almacenado el [MODULO ACCESO], que está considerado en el script INSERT_ADM_SISTEMA_CNT
*/
       SET NOCOUNT ON

       IF EXISTS(SELECT 1 FROM SISTEMA_CNT WHERE operativo='S') 
       BEGIN
             select Modulos.id_sistema
                    ,      Modulos.nombre_sistema
                    ,      Modulos.operativo
                    ,      Modulos.gestion
                    ,      Modulos.Orden
             from   (      SELECT  id_sistema
                                        ,      nombre_sistema
                                        ,      operativo
                                        ,      gestion
										-- +++cvegasan 2017.06.05 Se dejan NY fuera en procedimiento almacenado
											-- +++cvegasan 2018.04.26 Se deja fuera en procedimiento almacenado el [MODULO ACCESO]
										,      Orden  = case			
															when id_sistema = 'ADM' then -1 -- Se agrega este parámetro para exclusión en WHERE orden>=0
															when id_sistema = 'BEX' then 0
															when id_sistema = 'BNY' then 1
                                                            when id_sistema = 'BTR' then 2
                                                            when id_sistema = 'BCC' then 3
                                                            when id_sistema = 'BFW' then 4
                                                            when id_sistema = 'TUR' then 5
                                                            when id_sistema = 'PCS' then 6
                                                            when id_sistema = 'OPC' then 7
                                                            when id_sistema = 'SNY' then 8
                                                            when id_sistema = 'OPT' then 9
														end
											-- ---cvegasan 2018.04.26 Se deja fuera en procedimiento almacenado el [MODULO ACCESO]
										-- ---cvegasan 2017.06.05 Se dejan NY fuera en procedimiento almacenado
                                  FROM   SISTEMA_CNT
                                  WHERE  operativo    = 'S' 
                                  AND          gestion             = 'N'
                           )      Modulos
			-- +++cvegasan 2017.06.05 Se dejan NY afuera en procedimiento almacenado
			WHERE
				NOT  (CHARINDEX('NY',RTRIM(LTRIM(nombre_sistema))) > 0)
				-- +++cvegasan 2018.04.26 Se deja fuera en procedimiento almacenado el [MODULO ACCESO]
				AND Orden >= 0
				-- ---cvegasan 2018.04.26 Se deja fuera en procedimiento almacenado el [MODULO ACCESO]
			-- ---cvegasan 2017.06.05 Se dejan NY afuera en procedimiento almacenado
             order 
             by           Modulos.Orden
             
       END ELSE 
       BEGIN
             SELECT 'ERROR'
       END

       SET NOCOUNT ON
END
GO
