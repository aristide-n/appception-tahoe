module TimelinesHelper
  def parse(file_path)

    # Deserialize timeline dump file
    json_file = File.read(file_path)
    parsed_timeline_data = JSON.parse(json_file)

    @environment_data = parsed_timeline_data[0]

    timeline_events_data = parsed_timeline_data[1..(parsed_timeline_data.length-1)]

    @testing_sections_list = get_testing_sections(timeline_events_data)

    # Return a json string of the performance metrics
    return aggregate_performance_metrics.to_json

  end

  def get_testing_sections(event_objects_list)
    sections_list = []
    section_beginning = 0
    section_end = 0

    event_objects_list.each do |object|
      if deep_has_value?(object, "begin")
        section_beginning = event_objects_list.find_index(object)
      elsif deep_has_value?(object, "end")
        section_end = event_objects_list.find_index(object)
        sections_list << event_objects_list[section_beginning..section_end]
        section_beginning = 0
        section_end = 0
      end
    end

    return sections_list
  end

  def deep_has_value?(obj, value)
    result = false

    if obj.respond_to?(:value?) && obj.has_value?(value)
      result = true
    elsif obj.respond_to?(:each)
      obj.find{ |*a| result=deep_has_value?(a.last,value) }
      result
    else
      result
    end
  end

  def aggregate_performance_metrics
    aggregate_metrics = {}

    insert_environment_info(aggregate_metrics)

    insert_performanceMetrics(aggregate_metrics)

    return aggregate_metrics

  end

  def insert_environment_info(results_hash)

    results_hash["env"] = @environment_data
    ## Remove all special characters from the ENV info string, and map the remaining data into an Array
    #env_info_list = @environment_data.gsub(/;/i, ",").gsub(/\(/i, ",").gsub(/\)/i, ",").gsub(/\//i, ",").gsub(/ /i, ",").split(",").map(&:strip).reject(&:empty?)
    #
    #puts env_info_list.to_s

    ## Insert the OS version in the hash
    #if env_info_list.include?("Windows") && env_info_list.include?("NT")
    #  results_hash["os"] = "Windows NT"
    #  ver_index = env_info_list.index("NT") + 1
    #  results_hash["osVersion"] = env_info_list[ver_index]
    #elsif env_info_list.include?("Mac") && env_info_list.include?("OS")
    #  results_hash["os"] = "Mac OS X"
    #  ver_index = env_info_list.index("X") + 1
    #  results_hash["osVersion"] = env_info_list[ver_index]
    #else
    #  results_hash["os"] = "Unknown"
    #  results_hash["osVersion"] = "unknown"
    #end
    #
    ## Insert the chrome version
    #chrome_ver_index = env_info_list.index("Chrome")+1
    #results_hash["chromeVersion"] = env_info_list[chrome_ver_index]
  end

  def insert_performanceMetrics(results_hash)
    metrics_hash = {}

    # Get styling metrics
    metrics_hash["calculateStylesMetrics"] = get_styling_metrics

    # Get Layout metrics
    metrics_hash["layoutMetrics"] = get_layout_metrics

    # Get Frame rendering metrics
    metrics_hash["renderingMetrics"] = get_rendering_metrics

    # Get painting metrics
    metrics_hash["paintMetrics"] = get_painting_metrics

    #Insert the results in the hash
    results_hash["performanceMetrics"] = metrics_hash
  end

  def get_rendering_metrics
    rendering_timings = []

    @testing_sections_list.each do |section|
      # Set the flag to find the first frame rendering event
      is_frame_event_pending = true

      # Set the counter
      i = 0

      while is_frame_event_pending and i < section.length
        # Check the events of an object in the section
        current_object = section[i]

        # The true events list is the value of the "children" key, if any
        events_list = current_object["children"]

        if events_list.nil?
          i += 1
        else
          # Check for the beginFrame event; when found:
          # 1. push the timing of the object in the list of timings,
          # 2. set the frame_event_pending flag
          is_frame_event_found = check_for_event_type(events_list, "BeginFrame")

          if is_frame_event_found.nil?
            i += 1
          else
            rendering_timings.append(current_object["endTime"] - current_object["startTime"])
            is_frame_event_pending = false
          end
        end
      end
    end

    # create the hash of metrics
    rendering_metrics_hash = {}
    if rendering_timings.empty?
      rendering_metrics_hash["averageFrameRenderingTime"] = 0
      rendering_metrics_hash["maxFrameRenderingTime"] = 0
      rendering_metrics_hash["minFrameRenderingTime"] = 0
      rendering_metrics_hash["frameRenderingRepetitions"] = 0
    else
      rendering_metrics_hash["averageFrameRenderingTime"] = rendering_timings.sum.to_f / rendering_timings.length
      rendering_metrics_hash["maxFrameRenderingTime"] = rendering_timings.max
      rendering_metrics_hash["minFrameRenderingTime"] = rendering_timings.min
      rendering_metrics_hash["frameRenderingRepetitions"] = rendering_timings.length
    end

    return rendering_metrics_hash
  end


  def get_layout_metrics
    layout_timings = []

    @testing_sections_list.each do |section|
      # Set the flag to find the first layout event
      is_layout_event_pending = true

      # Set the counter
      i = 0

      while is_layout_event_pending and i < section.length
        # Check the events of an object in the section
        current_object = section[i]

        # The true events list is the value of the "children" key, if any
        events_list = current_object["children"]

        if events_list.nil?
          i += 1
        else
          # Check for the Layout event; when found:
          # 1. push the timing of the object in the list of timings,
          # 2. set the layout_event_pending flag
          layout_event_found = check_for_event_type(events_list, "Layout")

          if layout_event_found.nil?
            i += 1
          else
            layout_timings.append(layout_event_found["endTime"] - layout_event_found["startTime"])
            is_layout_event_pending = false
          end
        end
      end
    end

    # create the hash of metrics
    layout_metrics_hash = {}
    if layout_timings.empty?
      layout_metrics_hash["averageLayoutTime"] = 0
      layout_metrics_hash["maxLayoutTime"] = 0
      layout_metrics_hash["minLayoutTime"] = 0
      layout_metrics_hash["layoutRepetition"] = 0
    else
      layout_metrics_hash["averageLayoutTime"] = layout_timings.sum.to_f / layout_timings.length
      layout_metrics_hash["maxLayoutTime"] = layout_timings.max
      layout_metrics_hash["minLayoutTime"] = layout_timings.min
      layout_metrics_hash["layoutRepetition"] = layout_timings.length
    end

    return layout_metrics_hash
  end


  def get_styling_metrics
    styling_timings = []

    @testing_sections_list.each do |section|
      # Set the flag to find the first recalculate style event
      is_style_event_pending = true

      # Set the counter
      i = 0

      while is_style_event_pending and i < section.length
        # Check the events of an object in the section
        current_object = section[i]

        # The true events list is the value of the "children" key, if any
        events_list = current_object["children"]

        if events_list.nil?
          i += 1
        else
          # Check for the RecalculateStyles event; when found:
          # 1. push the timing of the object in the list of timings,
          # 2. set the style_event_pending flag
          style_event_found = check_for_event_type(events_list, "RecalculateStyles")

          if style_event_found.nil?
            i += 1
          else
            styling_timings.append(style_event_found["endTime"] - style_event_found["startTime"])
            is_style_event_pending = false
          end
        end
      end
    end

    # create the hash of metrics
    styling_metrics_hash = {}
    if styling_timings.empty?
      styling_metrics_hash["averageCalcStylesTime"] = 0
      styling_metrics_hash["maxCalcStylesTime"] = 0
      styling_metrics_hash["minCalcStylesTime"] = 0
      styling_metrics_hash["calcStylesRepetitions"] = 0
    else
      styling_metrics_hash["averageCalcStylesTime"] = styling_timings.sum.to_f / styling_timings.length
      styling_metrics_hash["maxCalcStylesTime"] = styling_timings.max
      styling_metrics_hash["minCalcStylesTime"] = styling_timings.min
      styling_metrics_hash["calcStylesRepetitions"] = styling_timings.length
    end

    return styling_metrics_hash
  end


  def get_painting_metrics
    painting_timings = []

    @testing_sections_list.each do |section|
      # Set the flag to find the all Paint events in the the rendering event object
      paint_events_pending = true

      # Set the counter
      i = 0

      # Initialize the array of paint event timings in the section
      section_painting_timings = []

      while paint_events_pending and i < section.length
        # Check the events of an object in the section
        current_object = section[i]

        # The true events list is the value of the "children" key, if any
        events_list = current_object["children"]

        if events_list.nil?
          i += 1
        else
          # Check for a paint events; when one is found:
          # 1. push the timing of the object in the list of section painting timings
          # 2. iterate over the other children of the object to find any other paint events
          # 3. set the paint_events_pending flag
          # 4. Add the section timings to the timings array
          paint_event_found = check_for_event_type(events_list, "Paint")

          if paint_event_found.nil?
            i += 1
          else
            section_painting_timings.append(paint_event_found["endTime"] - paint_event_found["startTime"])

            while !(another_paint_event = check_for_event_type(events_list, "Paint")).nil?
              section_painting_timings.append(another_paint_event["endTime"] - another_paint_event["startTime"])
            end

            paint_events_pending = false
            painting_timings.append(section_painting_timings)
          end
        end
      end
    end

    # create the hash of metrics
    painting_metrics_hash = {}
    if painting_timings.empty?
      painting_metrics_hash["averagePaintTime"] = 0
      painting_metrics_hash["maxPaintTime"] = 0
      painting_metrics_hash["minPaintTime"] = 0
      painting_metrics_hash["paintOccurrences"] = 0
    else
      painting_timings = painting_timings.flatten
      painting_metrics_hash["averagePaintTime"] = painting_timings.sum.to_f / painting_timings.length
      painting_metrics_hash["maxPaintTime"] = painting_timings.max
      painting_metrics_hash["minPaintTime"] = painting_timings.min
      painting_metrics_hash["paintOccurrences"] = painting_timings.length
    end

    return painting_metrics_hash
  end


  def check_for_event_type (list_of_objects, event_name)
    event_found = nil
    i = 0
    list_length = list_of_objects.length

    while event_found.nil? and i < list_length
      obj = list_of_objects[i]
      if obj.has_value?(event_name)
        event_found = obj

        if event_name == "Paint"
          # for multiple paints remove the object from this list
          list_of_objects.delete(obj)
        end
      else
        i += 1
      end
    end

    return event_found
  end
end
