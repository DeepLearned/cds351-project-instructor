program main
    use dataset_mod, only : dataset_t, summary_stats_t
    use io_mod, only: read_config, read_observations, write_summary
    use stats_mod, only : summarize_dataset

    implicit none

    type(dataset_t) :: obs
    type(summary_stats_t) :: summary
    
    ! namelist variables
    character(len=200) :: input_file
    character(len=200) :: output_file
    character(len=80) :: dataset_name
    
    call read_config("config.nml", input_file, output_file, &
        obs%name, obs%units, obs%missing_value)

    call read_observations(input_file, obs%values)
    
    summary = summarize_dataset(obs)

    call write_summary(output_file, obs%name, obs%units, &
        summary%minimum, summary%maximum, summary%mean, summary%nvalid)


end program main
