USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[USP_RPT_EJECUTIVO_USUARIO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_RPT_EJECUTIVO_USUARIO]
(
    @vbloqueado       BIT = 0
   ,@vVigente         CHAR(1) = 'S'
   ,@vTipoReporte     CHAR(40) = ''
)
AS
BEGIN
	DECLARE @vGlosa VARCHAR(100)
	SELECT @vGlosa = ''
	
	IF @vVigente = 'S'
	    SELECT @vGlosa = 'VIGENTE' 
	
	IF (@vbloqueado = 1 AND LTRIM(RTRIM(@vGlosa)) <> '')
	    SELECT @vGlosa = @vGlosa + '/BLOQUEADO'
	ELSE
	IF (@vbloqueado = 1 AND LTRIM(RTRIM(@vGlosa)) = '')
	    SELECT @vGlosa = 'BLOQUEADO'
	
	IF LTRIM(RTRIM(@vGlosa)) <> ''
	    SELECT @vGlosa = '-' + @vGlosa 
	
	IF @vTipoReporte = 'USUARIO'
	   OR @vTipoReporte = 'TODOS'
	BEGIN
	    SELECT 'ID_APLICACION' = fup.id_aplicacion
	          ,'ID_USER' = fup.id_user
	          ,'RUT+DV' = LTRIM(
	               RTRIM(
	                   CONVERT(
	                       CHAR(10)
	                      ,ISNULL((CASE WHEN fup.rut = 0 THEN RUT_EJECUTIVO END) ,fup.rut)
	                   )
	               )
	           ) + '-' + LTRIM(
	               RTRIM(
	                   ISNULL(
	                       (CASE WHEN fup.dv_rut_par = '0' THEN DV_RUT_EJEC END)
	                      ,fup.dv_rut_par
	                   )
	               )
	           )
	          ,'NOMBRES+APELLIDOS' = RTRIM(fup.nombres) + ' ' + RTRIM(fup.apellidos)
	          ,'CARGO' = fup.cargo
	          ,'E-MAIL' = fu.Email
	          ,'FONO' = fup.fono
	          ,'BLOQUEADO' = CASE 
	                              WHEN fu.IsLockedOut = 0 THEN 'Activa'
	                              ELSE     'Bloqueada'
	                         END
	          ,'VIG_USU' = CASE 
	                            WHEN fup.sw_vigente = 'S' THEN 'Si'
	                            WHEN fup.sw_vigente = 'N' THEN 'No'
	                            ELSE       'No Existe'
	                       END
	          ,'VIG_EJE' = CASE 
	                            WHEN fe.sw_vigente = 'S' THEN 'Si'
	                            WHEN fe.sw_vigente = 'N' THEN 'No'
	                            ELSE       'No Existe'
	                       END
	          ,'vGlosa' = LTRIM(RTRIM(@vTipoReporte)) + @vGlosa
	          ,'FECHA_CREACION' = fu.CreationDate
	          ,'FECHA_ELIMINACION' = fup.fecha_eliminacion
	    FROM   FMParametros.dbo.FWK_USERS fu
	           INNER JOIN FMParametros.dbo.FWK_USERS_PROFILES fup
	                ON  fup.id_aplicacion = fu.id_aplicacion
	                    AND fup.id_user = fu.id_user
	                    AND fu.IsLockedOut = @vbloqueado --siempre
	                    AND fup.sw_vigente = @vVigente --cuando sea informe usuario
	                        
	           LEFT JOIN FMParticipes.dbo.FMP_EJECUTIVOS fe
	                ON  fe.ALIAS_EJECUTIVO = fu.id_user --inner solo cuando sea ejecutivo y left cuando sea usuario
	                                                    --	AND fe.sw_vigente = @vVigente --Acuando sea informe ejecutivo
	    ORDER BY
	           fup.nombres              ASC
	END
	
	IF @vTipoReporte = 'EJECUTIVO'
	BEGIN
	    SELECT 'ID_APLICACION' = fup.id_aplicacion
	          ,'ID_USER' = fup.id_user
	          ,'RUT+DV' = LTRIM(RTRIM(CONVERT(CHAR(10) ,fe.RUT_EJECUTIVO))) +
	           '-' + fe.DV_RUT_EJEC
	          ,'NOMBRES+APELLIDOS' = fe.NOMBRE_EJECUTIVO
	          ,'CARGO' = fup.cargo
	          ,'E-MAIL' = fe.email
	          ,'FONO' = fe.fono
	          ,'BLOQUEADO' = CASE 
	                              WHEN fu.IsLockedOut = 0 THEN 'Activa'
	                              ELSE     'Bloqueada'
	                         END
	          ,'VIG_USU' = CASE 
	                            WHEN fup.sw_vigente = 'S' THEN 'Si'
	                            WHEN fup.sw_vigente = 'N' THEN 'No'
	                       END
	          ,'VIG_EJE' = CASE 
	                            WHEN fe.sw_vigente = 'S' THEN 'Si'
	                            WHEN fe.sw_vigente = 'N' THEN 'No'
	                       END
	          ,'vGlosa' = LTRIM(RTRIM(@vTipoReporte)) + @vGlosa
	          ,'FECHA_CREACION' = fu.CreationDate
	          ,'FECHA_ELIMINACION' = fup.fecha_eliminacion
	    FROM   FMParametros.dbo.FWK_USERS fu
	           INNER JOIN FMParametros.dbo.FWK_USERS_PROFILES fup
	                ON  fup.id_aplicacion = fu.id_aplicacion
	                    AND fup.id_user = fu.id_user
	                    AND fu.IsLockedOut = @vbloqueado --siempre
	                                                     --AND fup.sw_vigente = @vVigente --cuando sea informe usuario
	                        
	           INNER JOIN FMParticipes.dbo.FMP_EJECUTIVOS fe
	                ON  fe.ALIAS_EJECUTIVO = fu.id_user --inner solo cuando sea ejecutivo y left cuando sea usuario
	                    AND fe.sw_vigente = @vVigente --Acuando sea informe ejecutivo
	    ORDER BY
	           fe.NOMBRE_EJECUTIVO      ASC
	END
END
GO
