module Erp
  module Contents
    module Backend
      class ContentsController < Erp::Backend::BackendController
        before_action :set_content, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_contents, only: [:delete_all, :archive_all, :unarchive_all]

        # GET /contents
        def list
          @contents = Content.search(params).paginate(:page => params[:page], :per_page => 10)

          render layout: nil
        end

        # GET /contents/new
        def new
          @content = Content.new

          if request.xhr?
            render '_form', layout: nil, locals: {content: @content}
          end
        end

        # GET /contents/1/edit
        def edit
        end

        # POST /contents
        def create
          @content = Content.new(content_params)
          @content.creator = current_user

          if @content.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @content.id,
                value: @content.name
              }
            else
              redirect_to erp_contents.edit_backend_content_path(@content), notice: t('.success')
            end
          else
            if request.xhr?
              render '_form', layout: nil, locals: {content: @content}
            else
              render :new
            end
          end
        end

        # PATCH/PUT /contents/1
        def update
          if @content.update(content_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @content.id,
                value: @content.name
              }
            else
              redirect_to erp_contents.edit_backend_content_path(@content), notice: t('.success')
            end
          else
            render :edit
          end
        end

        # DELETE /contents/1
        def destroy
          @content.destroy

          respond_to do |format|
            format.html { redirect_to erp_contents.backend_contents_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # DELETE /contents/delete_all?ids=1,2,3
        def delete_all
          @contents.destroy_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # Archive /contents/archive?id=1
        def archive
          @content.archive

          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end

        # Unarchive /contents/unarchive?id=1
        def unarchive
          @content.unarchive

          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end

        # Archive /contents/archive_all?ids=1,2,3
        def archive_all
          @contents.archive_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # Unarchive /contents/unarchive_all?ids=1,2,3
        def unarchive_all
          @contents.unarchive_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # dataselect /contents
        def dataselect
          respond_to do |format|
            format.json {
              render json: Content.dataselect(params[:keyword])
            }
          end
        end

        # Move up /contents/up?id=1
        def move_up
          @content.move_up

          respond_to do |format|
          format.json {
            render json: {
            #'message': t('.success'),
            #'type': 'success'
            }
          }
          end
        end

        # Move down /contents/up?id=1
        def move_down
          @content.move_down

          respond_to do |format|
          format.json {
            render json: {
            #'message': t('.success'),
            #'type': 'success'
            }
          }
          end
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_content
            @content = Content.find(params[:id])
          end

          def set_contents
            @contents = Content.where(id: params[:ids])
          end

          # Only allow a trusted parameter "white list" through.
          def content_params
            params.fetch(:content, {}).permit(:name, :content, :position)
          end
      end
    end
  end
end