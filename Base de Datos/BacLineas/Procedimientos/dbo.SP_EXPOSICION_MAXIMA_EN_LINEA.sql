USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXPOSICION_MAXIMA_EN_LINEA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EXPOSICION_MAXIMA_EN_LINEA]
                      ( @cSistema	CHAR 	(03) 	,
						@nNumoper	NUMERIC	(10) 	
                       ) 
AS
BEGIN

	SET NOCOUNT ON
		DECLARE     @nMtoGrp 		NUMERIC (19,4)  ,
		            @nCodigo_grupo	VARCHAR(5)      ,
                            @nValorUF           FLOAT           ,
                            @cFecProc           DATETIME   
            


                IF @cSistema='BTR' OR @cSistema='BEX' 
                  BEGIN	
                              				
						SELECT 	@nMtoGrp  = 0
						SELECT  @nCodigo_grupo =''

						IF @cSistema='BTR' 
                                                BEGIN

                                                   SELECT  @cFecProc = acfecproc  FROM  BACTRADERSUDA.dbo.MDAC with(nolock)
                                                   SELECT  @nValorUF = vmvalor FROM BACPARAMSUDA.dbo.VALOR_MONEDA with(nolock) WHERE vmcodigo =998 and vmfecha =@cFecProc
 					
							SELECT 	DISTINCT @nMtoGrp = case when motipoper ='CP' then a.movpresen/@nValorUF else  (a.movpresen/@nValorUF)*(-1) end
					  		FROM BACTRADERSUDA.dbo.MDMO a with(nolock)
							WHERE	a.Id_Sistema    = @cSistema
							    AND a.monumoper     = @nNumoper							



                                                         SELECT  DISTINCT @nCodigo_grupo = b.codigo_grupo
           					  	 FROM 	BACTRADERSUDA.dbo.mdmo a with(nolock), GRUPO_POSICION_DETALLE b with(nolock)
              					   	 WHERE  a.Id_Sistema = @cSistema
                   					    AND a.monumoper   = @nNumoper	
                        				    AND a.morutemi = b.rut_emisor
                					    AND a.mocodigo   = b.codigo_instrumento     
                        				    AND a.momonemi	  = b.codigo_moneda
   



   						END
						ELSE 
                               BEGIN

			                 SELECT  @cFecProc = acfecproc  FROM  BACBONOSEXTSUDA.dbo.text_arc_ctl_dri with(nolock)
 					
							--> Determina si es operación generada en CHile o NY
							   DECLARE @EsOperacionNY as char(2)
							   SET @EsOperacionNY = 'No'
 								IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri with(nolock) where monumoper = @nNumoper)
											set @EsOperacionNY = 'Si'
		
							IF @EsOperacionNY = 'No'
									BEGIN


										SELECT 	DISTINCT @nMtoGrp = case when motipoper ='CP' then a.movpresen/1000 else  (a.movpresen/1000)*(-1) end
					  					FROM BACBONOSEXTSUDA.dbo.text_mvt_dri a with(nolock)
										WHERE	a.monumoper     = @nNumoper							

										 SELECT  DISTINCT @nCodigo_grupo = b.codigo_grupo
                  						FROM 	BACBONOSEXTSUDA.dbo.text_mvt_dri a with(nolock), GRUPO_POSICION_DETALLE b with(nolock)
										  WHERE  a.monumoper   = @nNumoper	
                         				   AND a.morutemi = b.rut_emisor
											AND a.cod_familia   = b.codigo_instrumento     
                        					AND a.momonemi	  = b.codigo_moneda
 
							END

							IF @EsOperacionNY = 'Si'
									BEGIN


										SELECT 	DISTINCT @nMtoGrp = case when motipoper ='CP' then a.movpresen/1000 else  (a.movpresen/1000)*(-1) end
					  					FROM BACBONOSEXTNY.dbo.text_mvt_dri a with(nolock)
										WHERE	a.monumoper     = @nNumoper							

										 SELECT  DISTINCT @nCodigo_grupo = b.codigo_grupo
                  						FROM 	BACBONOSEXTNY.dbo.text_mvt_dri a with(nolock), GRUPO_POSICION_DETALLE b with(nolock)
										  WHERE  a.monumoper   = @nNumoper	
                         				   AND a.morutemi = b.rut_emisor
											AND a.cod_familia   = b.codigo_instrumento     
                        					AND a.momonemi	  = b.codigo_moneda
 
							END

						

						END 



						

						
						UPDATE 	POSICION_GRUPO
						SET 	totalocupado = totalocupado  + @nMtoGrp
						WHERE	Codigo_Grupo = @nCodigo_grupo




                                        	UPDATE 	POSICION_GRUPO
                                        	SET 	totaldisponible = totalposicion - totalocupado
                                        	WHERE 	totalposicion > totalocupado



                                           	UPDATE 	POSICION_GRUPO
                                        	SET 	totalexcedido = (totalposicion - totalocupado) * -1
                                        	WHERE 	totalposicion < totalocupado



                                        	UPDATE 	POSICION_GRUPO
                                        	SET 	porcentaje = (totalocupado/totalposicion)* 100
                                           	WHERE 	totalposicion > 0 



                  END





	SET NOCOUNT OFF

END
GO
