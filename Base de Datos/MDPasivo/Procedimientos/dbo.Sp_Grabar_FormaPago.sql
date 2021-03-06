USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_FormaPago]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Grabar_FormaPago] ( @codigo     		NUMERIC(2)  ,
                                       	   @glosa      		CHAR   (30) ,
                                       	   @perfil     		CHAR   (9)  ,
                                       	   @codgen     		NUMERIC(3)  ,
                                       	   @glosa2     		CHAR   (8)  ,
                                       	   @cc2756     		CHAR   (1)  ,
                                       	   @afectacorr 		CHAR   (1)  ,
                                       	   @diasvalor  		NUMERIC(3)  ,
                                       	   @numcheque  		CHAR   (1)  ,
                                       	   @ctacte     		CHAR   (1)  ,
                                       	   @settlement 		CHAR   (1)  ,
                                       	   @Relacion_bcch 	NUMERIC(1)  ,
                                       	   @Formabcch  		CHAR   (1)  = 'N',
					   @Contable	        CHAR   (1)  = 'S')
AS
BEGIN




   	SET DATEFORMAT DMY
	SET NOCOUNT ON

     IF EXISTS (SELECT codigo FROM FORMA_DE_PAGO WHERE codigo = @codigo AND ESTADO='A' )
     BEGIN      
             SELECT -1, 'Error : Forma de pago Utilizada Anteriormente'
             RETURN 1
     END 


        IF EXISTS (SELECT codigo FROM FORMA_DE_PAGO WHERE codigo = @codigo )
        BEGIN
             UPDATE Forma_de_Pago
                SET codigo        = @codigo     ,
                    glosa         = @glosa      ,
                    perfil        = @perfil     ,
                    codgen        = @codgen     ,
                    glosa2        = @glosa2     ,
                    cc2756        = @cc2756     ,
                    afectacorr    = @afectacorr ,
                    diasvalor     = @diasvalor  ,
                    numcheque     = @numcheque  ,
                    ctacte        = @ctacte     ,
                    settlement 	  = @settlement ,
                    relacion_Bcch = @relacion_Bcch,
		    forma_central = @Formabcch,
		    Contable      = @Contable
              WHERE codigo = @codigo
   
             IF @@ERROR <> 0  BEGIN
                SELECT -1, 'Error : No pudo actualizar la Tabla Formas de Pago'
                RETURN 1
             END
   
        END ELSE BEGIN
             INSERT FORMA_DE_PAGO ( codigo     ,
                           glosa      ,
                           perfil     ,
                           codgen     ,
                           glosa2     ,
                           cc2756     ,
                           afectacorr ,
                           diasvalor  ,
                           numcheque  ,
                           ctacte     ,
                           settlement ,
                           relacion_bcch,
			   forma_central,
			   Contable)
                  VALUES( @codigo     ,
                          @glosa      ,
                          @perfil     ,
                          @codgen     ,
                          @glosa2     ,
                          @cc2756     ,
                          @afectacorr ,
                          @diasvalor  ,
                          @numcheque  ,
                          @ctacte     ,
                          @settlement ,
                          @relacion_bcch,
			  @Formabcch,
			  @Contable)
   
             IF @@ERROR <> 0  BEGIN
                SELECT -1, 'Error : No pudo Insertar la Tabla Formas de Pago'
                RETURN 1
             END
        END

END  -- PROCEDURE

--sp_Grabar_FormaPago  8, 'CHEQUE BANCO CENTRAL', 'CH.BCCH', 1, 'CH. BCCH', 'S', 'N', 0, 'S', 'S', '0', 2, 'S'
GO
