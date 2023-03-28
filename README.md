# game_list_task
This is a Project for a Interview Task.


Project OverView 
--BLoc Pattern is used to manage different app state for different screen in the app.
--Sqlf Database is used to Safe local data.
--Getit is used for Dependency Injection to hold database object
--Local json string are used to save different strings


Project Folder/File Details

--database : This folder contain Database helper File which is responsible for holding database and operations i.e insert, update , fetch

--di : This folder contains our dependency class which holds our DatabaseHelper Object.

--repository: This folder holds our model and in future will hold our api repository class to call api and store data in database.

--ui folder contains all the screen respective folders in which we have 1 screen ui respect to that screen and than we have widget folder
        all the widgets which we will use in that screen. Every widget folder has its ui file its event file and its state files.
  -- Home screen has List and Filter widget. List to populate list and filter to handle home screen filters.
    -- GameListBloc has 3 states loading : when data is loading, no_item : when there is no item in DB, update: when we need to updated list
            from sort, delete, insert or update events.

  -- Form screen has 1 form widget which will handle data entry in the table
    --
