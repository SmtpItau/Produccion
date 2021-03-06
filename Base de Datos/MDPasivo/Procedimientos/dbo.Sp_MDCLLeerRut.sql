USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCLLeerRut]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_MDCLLeerRut]
            (   @nrutcli     NUMERIC	(09)
            ,   @ndigito     CHAR	(01)
            ,   @ncodcli     NUMERIC	(09)
            )
AS
BEGIN

   SET NOCOUNT OFF
   SET DATEFORMAT dmy


   SELECT       clrut                               ,			--1
                cldv                                ,			--2
                clcodigo                            ,			--3
                clnombre                            ,			--4
                clgeneric                           ,			--5
                cldirecc                            ,  			--6
		clcomuna                            ,			--7
                clregion                            ,			--8
                CONVERT( CHAR(10), clfecingr, 103 ) ,			--9
                clctacte                            ,			--10
                clfono                              ,			--11
                clfax                               ,			--12
                cltipcli                            ,			--13
                clcalidadjuridica                   ,			--14
                clciudad                            ,			--15
                clmercado                           ,			--16
	        clpais				    ,			--17
                clnomb1                             ,			--18
                clnomb2                             ,			--19
                clapelpa                            ,			--20
                clapelma                            ,			--21
                clctausd                            ,			--22
                climplic                            ,			--23
                claba                               ,           	--24
                clchips                             ,       		--25
                clswift                             ,			--26
                clopcion                            ,			--27
		'clrelacion' 			     = CASE WHEN clrelacion = 0 THEN 3 
							    ELSE clrelacion 
							    END ,	--28
		clcatego                            ,			--29
		clsector                            ,			--30
		clclsbif			    ,			--31
		clactivida                          ,			--32
		cltipemp                            ,			--33
		relbco 	                            ,			--34
		poder                               ,			--35
		firma                               ,			--36
		infosoc                             ,			--37
		art85                               ,			--38
		dec85                               ,			--39
                rut_grupo                           ,			--40
	        clcodfox                            ,			--41
		cod_inst                            ,			--42
		clcodban			    ,			--43
                oficinas                            , 			--44
                clclaries                           ,  			--45
                codigo_Otc                          , 			--46
                Bloqueado                           ,			--47
                'clvalidalinea'                      = CASE WHEN clvalidalinea = 'S' THEN 'SI' 
                                                            ELSE 'NO'
                                                            END  ,	--48
                'Rut_Grupo'                          = Rut_Grupo ,	--49
		CodNif							-- 50 (09/11/2004 jspp Interfaz Contabilidad a España)
	
		FROM	CLIENTE    
		WHERE	(clrut = @nrutcli AND clcodigo = @ncodcli)
                AND	(cldv  = @ndigito OR @ndigito = ' ')

END 


GO
