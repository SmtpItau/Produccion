USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNGrabar]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_MNGrabar](@mncodmon1   numeric (3,0) ,
                             @mnnemo1     char    (05)  ,
                             @mnsimbol1   char    (05)  ,
                             @mndescrip1  char    (30)  ,
                             @mnredondeo1 numeric (2,0) ,
                             @mnbase1     numeric (3,0) ,
                             @mntipmon1   char    (01)  ,
                             @mnperiodo1  numeric (2,0) ,
                             @mncodsuper1 numeric (3,0) ,
                             @mncodfox    char    (  6) ,
        		     @mncodcor    numeric (  7) ,
			     @mncodbcch   numeric (3,0) ,
			     @mncodpais	  numeric (3,0) ,  
			     @mone        numeric (1,0) ,
			     @refmerc	  numeric (1,0) ,
			     @refusd	  numeric (1,0) ,
		             @mnlimite    numeric (19,4) ,
		             @mncodcorrespC numeric ( 5),
		             @mncodcorrespV numeric ( 5),
		             @mnctacamb   char    ( 10) ,
                             @mncanasta   char    (  2))

AS
BEGIN
set nocount on
DECLARE @mnmx CHAR(1)

BEGIN TRANSACTION

SELECT @mnmx = (CASE WHEN @mone = 1 THEN 'C' ELSE '' END)

/*
    IF EXISTS(SELECT mncodsuper FROM MONEDA WHERE mncodmon <> @mncodmon1 AND mncodsuper = @mncodsuper1)
       BEGIN
         SELECT '13010'
	 set nocount off
         RETURN
       END

    IF EXISTS(SELECT mncodbanco FROM MONEDA WHERE mncodmon <> @mncodmon1 AND mncodbanco = @mncodbcch)
       BEGIN
         SELECT '13020'
	 set nocount off
         RETURN
       END    
*/
 
    IF EXISTS(SELECT mncodmon FROM MONEDA WHERE mncodmon = @mncodmon1)
       UPDATE MONEDA SET mncodmon   = @mncodmon1  ,
                         mnnemo     = @mnnemo1     ,
                         mnsimbol   = @mnsimbol1   ,
                         mnglosa    = @mndescrip1  ,
                         mnredondeo = @mnredondeo1 ,
                         mnbase     = @mnbase1     ,
                         mntipmon   = @mntipmon1   ,
                         mnperiodo  = @mnperiodo1  ,
                         mncodsuper = @mncodsuper1 ,
                         mncodfox   = @mncodfox    ,
                         mncodcor   = @mncodcor    ,
                         mncodbanco = @mncodbcch   ,
                         mnmx       = @mnmx        ,
	                 codigo_pais= @mncodpais   ,
		         mnextranj  = @mone	,
		         mnrefusd   = @refusd,
		         mnnemsuper = '',
		         mnnembanco = '',
		         mndecimal  = 0,
		         mncodpais  =  mncodpais ,--0 ES LO QUE ESTABA 
		         mnfactor   = 0,
		         mnlocal    = 0,
		         mningval   = 0,
		         mnvalor    = 0,
		         mnrefmerc  = @refmerc,
		         mnvalfox   = 0,
		         mniso_coddes = 'C',	
		         mnrrda     = CASE @refusd WHEN 1 THEN 'M' ELSE 'D' END ,
		         mnlimite   = @mnlimite,
                         mncodcorrespC = @mncodcorrespV,
 	                 mncodcorrespV = @mncodcorrespC,
			 mnctacamb  = @mnctacamb,
                         mncanasta  = @mncanasta
              WHERE    mncodmon   = @mncodmon1

    ELSE
       INSERT INTO MONEDA (   mncodmon    ,   
                              mnnemo      ,
                              mnsimbol    ,   
                              mnglosa     ,
                              mnredondeo  , 
                              mnbase      ,
                              mntipmon    ,
                              mnperiodo   , 
                              mncodsuper  ,
                              mncodfox    ,
  			      mncodcor    ,
			      mncodbanco  ,
			      codigo_pais ,
                              mnmx        ,
                              mnextranj ,
                              mnrefmerc ,
			      mnrefusd  ,
		              mnnemsuper ,
			      mnnembanco ,
		              mndecimal  ,
			      mncodpais  ,
		   	      mnfactor  ,
			      mnlocal  ,
			      mningval,
			      mnvalor,
			      mnvalfox ,
			      mniso_coddes,
			      mnrrda,
                              mncodcorrespC,
 		              mncodcorrespV,
			      mnctacamb,
			      mncanasta)

		VALUES     (@mncodmon1    , 
                            @mnnemo1      , 
                            @mnsimbol1    , 
                            @mndescrip1   , 
                            @mnredondeo1  , 
                            @mnbase1      ,  
                            @mntipmon1    , 
                            @mnperiodo1   , 
                            @mncodsuper1  ,
                            @mncodfox     ,
			    @mncodcor	  ,
			    @mncodbcch	  , 
                            @mncodpais    ,
                            @mnmx         ,
			    @mone	  ,
     			    @refmerc,
			    @refusd,  
			    '',
			    '',
			    @mncodpais, -- 0 ES LO QUE HABIA
			    0,
			    0,
			    0,
			    0,
			    0,
			    0,
			    'C',
			    '',
                            @mncodcorrespC,
 		            @mncodcorrespV,
                            @mnctacamb,
			    @mncanasta )


    IF @@ERROR <> 0 
        BEGIN
        ROLLBACK TRANSACTION
	SELECT 'ERR'          -- SI OCURRE ALGUN ERROR
	SET NOCOUNT OFF
	RETURN	
     END
                     
     COMMIT TRANSACTION       -- SI GRABA 
     SELECT 'Ok'
     SET NOCOUNT OFF
     RETURN

END














GO
