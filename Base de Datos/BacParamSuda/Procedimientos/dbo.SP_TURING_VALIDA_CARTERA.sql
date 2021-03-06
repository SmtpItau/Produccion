USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_VALIDA_CARTERA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TURING_VALIDA_CARTERA]
						(@categ    as varchar(06),
						 @tbcodigo1 as varchar(03),
						 @Existe   as varchar(01) OUTPUT)
AS 
 BEGIN
  Begin try
	  SET NOCOUNT ON
	    
    		if exists(select  * from TABLA_GENERAL_DETALLE
	 where tbcateg =@categ
	 and   tbcodigo1=@tbcodigo1)--'T' )

			   begin
					select @Existe='S'
			   end
			else
			   begin
					select @Existe='N'
			end 
     return
	 SET NOCOUNT OFF
  End Try
  Begin Catch
     select @Existe='N'
     return
  End Catch 
END

/*
SELECT tbcodigo1, * FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1111'
select *from VIEW_TBL_RELACION_LIBRO_CARTERASUPER where Rlc_idSistema ='BFW'
select *from VIEW_REL_USUARIO_NORMATIVO where Ucn_Usuario='XTORRICO' and Ucn_Sistema ='BFW'
*/
GO
