CREATE TABLE [dbo].[SIC_sys_AccessPermission] (
    [IDs]        INT           IDENTITY (1, 1) NOT NULL,
    [priority]   INT           NOT NULL,
    [Permission] VARCHAR (20)  NOT NULL,
    [comments]   VARCHAR (100) NULL,
    CONSTRAINT [PK_SIC_sys_AccessPermission] PRIMARY KEY CLUSTERED ([priority] ASC, [Permission] ASC)
);

