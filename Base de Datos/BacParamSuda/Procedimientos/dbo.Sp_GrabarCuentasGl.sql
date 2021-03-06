USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GrabarCuentasGl]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_GrabarCuentasGl]
						(   @nCodTr       INT,		    -- 1	
							@nCodCa       INT,		    -- 2
							@nCodCo       VARCHAR(30),  -- 3
							@cDesc        CHAR(50),     -- 4
							@cCtaGl       CHAR(12),     -- 5
							@cCtaSup      CHAR(12),     -- 6
							@cCtaAlt      CHAR(12),     -- 7
							@cCtaAltPer   CHAR(12),     -- 8
							@cCtaCosif    CHAR(12),     -- 9
							@cCtaCosif_G  CHAR(12),     -- 10 
							@cCtaINT      CHAR(12),     -- 11
							@cCtaREA      CHAR(12),     -- 12 
							@cCtaGL_GRM	  CHAR(12),
							@cCtaSbif_GRM CHAR(12))
								 
										
AS
/*********************************************************************************
DESCRIPCION    : Inserta Data - Usuado en mantenedor BacMntCuentasGL (BacParam)
**********************************************************************************/
BEGIN

  INSERT Tabla_Glcode 
  VALUES (  @nCodTr  -- 1				   
          , @nCodCa  -- 2				   
          , @nCodCo  -- 3 				   
          , @cDesc   -- 4				   
          , @cCtaGl  -- 5				   
          , @cCtaSup -- 6 				   
          , @cCtaAlt -- 7				   
          , @cCtaCosif --8				   
          , @cCtaCosif_G -- 9			   
          , @cCtaINT -- 10				   
          , @cCtaREA -- 11				   
          , @cCtaAltPer
		  , @cCtaGL_GRM
		  , @cCtaSbif_GRM
		  ) -- 12		
		  
		
		  	   
END								
								
								
GO
