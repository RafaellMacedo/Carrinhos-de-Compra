class ApplicationController < ActionController::API
    private
    
    def add_cart_required_fields
        render json: { error: "Produto_id e quantidade são obrigatórios" }, status: :bad_request
    end

    def product_not_found
        render json: { error: "Produto não encontrado" }, status: :not_found
    end

    def remove_product_not_in_cart
        render json: { error: "Produto não existe no carrinho" }, status: :not_found
    end

    def cart_not_exist
        render json: { error: "Carrinho não existe" }, status: :not_found
    end

    def last_product_removed
        render json: { message: "Carrinho agora esta vázio" }, status: :ok
    end
end
