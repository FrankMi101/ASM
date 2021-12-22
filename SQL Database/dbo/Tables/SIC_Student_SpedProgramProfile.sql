CREATE TABLE [dbo].[SIC_Student_SpedProgramProfile] (
    [IDs]            INT           IDENTITY (1, 1) NOT NULL,
    [SchoolYear]     VARCHAR (8)   NOT NULL,
    [StudentID]      VARCHAR (15)  NULL,
    [Exceptionality] VARCHAR (10)  NULL,
    [Placement]      VARCHAR (2)   NULL,
    [StartDate]      SMALLDATETIME NULL,
    [EndDate]        SMALLDATETIME NULL,
    [lu_date]        SMALLDATETIME NULL,
    [lu_user]        VARCHAR (30)  NULL,
    [lu_function]    VARCHAR (50)  NULL
);

