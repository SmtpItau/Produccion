USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_INFORMECARTERA_VIG_IM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RPT_INFORMECARTERA_VIG_IM]
   (   @FecProc	        CHAR(8)
   ,   @Cartera_INV     INTEGER
   ,   @Mesa_Origen   SMALLINT
   ,   @Cat_Cart_Norm	CHAR(10) = '1111' -- '1554'
   ,   @Cat_Libro	CHAR(10) = '1552'
   ,   @Cat_Area_Resp	CHAR(10) = '1553'
   ,   @Cat_Cart_Fin	CHAR(10) = '204'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Glosa_Cartera	CHAR(50)
   ,	   @Glosa_Cart_Norm	CHAR(50)
   ,	   @Glosa_Libro		CHAR(50)
   ,	   @Glosa_Area_Resp	CHAR(50)
  ,	   @Glosa_Mesa		CHAR(50)

   SELECT  @Glosa_Cartera	= '' 
   ,	   @Glosa_Cart_Norm	= ''
   ,	   @Glosa_Libro		= ''
   ,	   @Glosa_Area_Resp	= ''
  ,	   @Glosa_Mesa		= ''


   IF @Cartera_INV = '' 
      SELECT @Glosa_Cartera = '< TODAS >'
   ELSE
      SELECT @Glosa_Cartera = ISNULL(TBGLOSA,'')
      FROM   VIEW_TABLA_GENERAL_DETALLE
      WHERE  tbcateg	    = @Cat_Cart_Fin
      AND    tbcodigo1	    = @Cartera_INV

   IF @Mesa_Origen = ''
       SELECT @Glosa_Mesa = '< TODAS >'
   ELSE
      SELECT @Glosa_Mesa =  ISNULL(TBGLOSA,'')
      FROM   VIEW_TABLA_GENERAL_DETALLE
      WHERE  tbcateg	    = 245
      AND    tbcodigo1	    = @Mesa_Origen


 
   CREATE TABLE #temp_cartera
		(	numope		char   (12)	not null default ' '	,--1
			nemotecnico	char   (20)	not null default ' '	,--2
			nom_nemo	char   (50)	not null default ' '	,--3
			Fec_vcto	datetime	not null default ' '	,--4
			fec_emi		datetime	not null default ' '	,--5
			Emisor		char   (60)	not null default ' '	,--6
			Tasa_Cupon	numeric(09,4)	not null default 0	,--7
			Pvp		numeric(19,7)	not null default 0	,--8
			Moneda		char   (03)	not null default ' '	,--9
			Nominal		numeric(19,4)	not null default 0	,--10
			Int_dev_com	numeric(19,4)	not null default 0	,--11
			Val_pag_com	numeric(19,4)	not null default 0	,--12
			Fec_com		datetime	not null default ' '	,--13
			Tir		numeric(19,7)	not null default 0	,--14
			Val_lib_actual	numeric(19,4)	not null default 0	,--15
			Pvp_merc	numeric(19,7)	not null default 0	,--16
			Val_merc	numeric(19,4)	not null default 0	,--17
			Interes		numeric(19,4)	not null default 0	,--18
			Interes_acum	numeric(19,4)	not null default 0	,--19
			Prox_ven_int	datetime	not null default ' '	,--20
			Prox_ven_cap	datetime	not null default ' '	,--21
			Operador	char   (30)	not null default ' '	,--22
			titulo		VARCHAR(200)	not null default ' '	,--23
			sw		numeric(01)	not null default 0 	,--24
			cartera		char   (50)	not null default ' '	,--27
			NombreEntidad   char   (50)	NOT NULL DEFAULT ' '	,--28
			DireccEntidad   char   (50)	NOT NULL DEFAULT ' '	,--29
			ClasifEmi	char   (50)	NOT NULL DEFAULT ' '	,--30
               		TirMercado	numeric(19,7)	not null default 0	,--31
              		Duracion        numeric(19)	not null default 0	,--32
               		ValorProx       numeric(19,7)	not null default 0	,--33
			PrincDia	numeric(19,4)	not null default 0	,--34
			CarteraINV_OP	Char   (50)	Not Null Default ' '	,--35
			Cartera_Selec   Char   (50)	Not Null Default ' '	,--36
			Glosa_Moneda	Char   (70)	Not Null Default ' '	,--37
			clasificacion1	Char   (40)	Not Null Default ' '	,--38
			clasificacion2	Char   (40)	Not Null Default ' '	,--39
			tipo_corto1	Char   (30)	Not Null Default ' '	,--40
			tipo_largo1	Char   (30)	Not Null Default ' '	,--41
			tipo_corto2	Char   (30)	Not Null Default ' '	,--42
			tipo_largo2	Char   (30)	Not Null Default ' '	,--43
			Glosa_Libro	CHAR  (50)	Not Null Default ' '	,--44
			Glosa_Area_Resp CHAR   (50)	Not Null Default ' '	,--45
			Libro		CHAR	(50)	Not Null Default ' '	,--46
			Cartera_Norm	CHAR	(50)	Not Null Default ' '	,--47
			NombreMesaOri	CHAR(50)	Not Null Default ' '	,--48
			NombreCarteraOri CHAR(50)	Not Null Default ' '	,--49
			Mesa_Selec	CHAR(50)	Not Null Default ' '	,--50
			Cartera_Origen	CHAR(1)	Not Null Default ' '

		)

                --	        COMPRAS
                INSERT INTO 	#temp_cartera
		SELECT 	/*001*/ rsnumdocu
                ,       /*002*/ a.id_instrum
                ,       /*003*/ b.Descrip_familia
                ,       /*004*/ rsfecvcto
                ,       /*005*/ rsfecemis
                ,       /*006*/ (select nom_emi from text_emi_itl where rut_emi = rsrutemis and rscodemi = rscodemi)
                ,       /*007*/ rstasemi
                ,       /*008*/ rspvp
                ,       /*009*/ (select MNNEMO from VIEW_moneda where MNCODMON = rsmonemi)
                ,       /*010*/ rsnominal
                ,       /*011*/ rsint_compra
                ,       /*012*/ rsvalcomu
                ,       /*013*/ rsfecpago
                ,       /*014*/ rstir
                ,       /*015*/ rsvppresen
                ,       /*016*/ rspvpmerc
                ,       /*017*/ rsvalmerc
                ,       /*018*/ rsinteres
                ,       /*019*/ rsinteres_acum
                ,       /*020*/ rsfecpcup
                ,       /*021*/ rsfecpvencap
                ,       /*022*/ a.operador_banco
                ,       /*023*/ ISNULL((SELECT	'INFORME DE CARTERA VIGENTE INTRAMESAS ' 
                              + LTRIM(RTRIM(ISNULL(TBGLOSA,'NO ENCONTRADO'))) 
                              + ' AL ' 
                              + LTRIM(RTRIM(CONVERT(CHAR(11),CONVERT(DATETIME,@FECproc,103))))
				        FROM	VIEW_TABLA_GENERAL_DETALLE 
				        WHERE	tbcateg		= @Cat_Cart_Norm 
				        AND	tbcodigo1	= a.codigo_carterasuper),'NO ENCONTRADO')
                ,       /*024*/ 1
                ,       /*027*/ a.codigo_carterasuper
                ,       /*028*/ ISNULL( (Select rcnombre from view_entidad),' ')
                ,       /*029*/ ISNULL( (Select rcdirecc from view_entidad),' ')
                ,       /*030*/ ISNULL(( select TBGLOSA from view_tabla_general_detalle , view_emisor where TBCATEG = 210  and TBCODIGO1 = emtipo and emrut = rsrutemis and emcodigo = rscodemi) , '')
                ,       /*031*/ a.rstirmerc
                ,       /*032*/ datediff(d,rsfecemis,rsfecvcto)
                ,       /*033*/ rsvppresenx
                ,       /*034*/ principaldia
                ,       /*035*/ ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Cart_Fin AND TBCODIGO1 = c.tipo_inversion),'No Especificado')
                ,       /*036*/ @Glosa_Cartera
                ,       /*037*/ (select MNGLOSA from VIEW_moneda where MNCODMON = rsmonemi )
                ,       /*038*/ emi.clasificacion1
                ,       /*039*/ emi.clasificacion2
                ,       /*040*/ emi.tipo_corto1
                ,       /*041*/ emi.tipo_largo1
                ,       /*042*/ emi.tipo_corto2
                ,       /*043*/ emi.tipo_largo2
 	  ,	/*044*/ @Glosa_Libro
	  ,	/*045*/ @Glosa_Area_Resp
	  ,	/*046*/ ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Libro	AND TBCODIGO1 = c.Id_Libro ),'No Especificado')
	  ,	/*047*/ ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Cart_Norm	AND TBCODIGO1 = c.codigo_carterasuper),'No Especificado')
	  ,	/*048*/ ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '245' AND TBCODIGO1 = @Mesa_Origen),'No Especificado')
	  ,	/*049*/ ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Cart_Fin AND TBCODIGO1 = a.Tipo_Cartera_Financiera),'No Especificado')
	  ,	/*050*/ @Glosa_Mesa
	  ,	a.Tipo_Cartera_Financiera
                FROM    CAR_ticketbonext            c
                        INNER JOIN RES_ticketbonext     a    ON c.cpnumdocu   = a.rsnumdocu and c.cpcorrelativo = a.rscorrelativo 
                        INNER JOIN text_fml_inm b    ON a.cod_familia = b.cod_familia
                        INNER JOIN text_emi_itl emi  ON emi.rut_emi   = a.rsrutemis
               WHERE  a.rsfecpro            =  @FecProc
               AND    a.rstipoper           = 'DEV'
               AND    a.rscartera          NOT IN(334,335)
 	 AND   (c.tipo_cartera_financiera = @Cartera_INV OR @Cartera_INV='')
	 AND  (c.mesa_origen = @Mesa_Origen OR @Mesa_Origen = '')

         IF (SELECT COUNT(1) FROM #temp_cartera) = 0 
         BEGIN
            DECLARE @TITULO  VARCHAR(200)
            SELECT  @TITULO  = 'INFORME DE CARTERA VIGENTE INTRAMESAS ' + LTRIM(RTRIM(@Glosa_Cart_Norm)) + ' ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FECproc),103)

            INSERT INTO #temp_cartera 
            (	titulo	
            ,	sw	
            ,	Cartera_Selec	
            ,	Glosa_Libro	
            ,	Glosa_Area_Resp
           )
           VALUES	
           (    @TITULO
            ,	0	
            ,	@Glosa_Cartera		
            ,	@Glosa_Libro        	
            ,	@Glosa_Area_Resp
           )
        END				

	SELECT DISTINCT * FROM #temp_cartera
	ORDER BY nemotecnico, numope

END

GO
